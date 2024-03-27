import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onetheatre/view/Login_and_registration/login.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as path;

class ProfileController with ChangeNotifier {
  final picker = ImagePicker();
  XFile? profpic;

  var userdata;
  User? user;
  String? userid;

  FirebaseStorage storage = FirebaseStorage.instance;

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    user = FirebaseAuth.instance.currentUser;
    userid = user!.uid;

    userdata = await FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.uid)
        .get();
    notifyListeners();
    return userdata;
  }

  void selectimage(context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  'Change Profile Picture',
                  style: GoogleFonts.salsa(fontSize: 17),
                ),
              ),
              ListTile(
                title: Text(
                  'Camera',
                  style: GoogleFonts.salsa(),
                ),
                leading: Icon(Icons.camera),
                onTap: () {
                  uploadimage("camera");
                },
              ),
              ListTile(
                title: Text(
                  'Galary',
                  style: GoogleFonts.salsa(),
                ),
                leading: Icon(Icons.image),
                onTap: () {
                  uploadimage("galary");
                },
              ),
            ],
          );
        });
  }

  Future<void> uploadimage(String imagefrom) async {
    try {
      profpic = await picker.pickImage(
          source:
              imagefrom == "camera" ? ImageSource.camera : ImageSource.gallery);
      final String filename = '${Uuid().v4()}.${path.extension(profpic!.path)}';
      final profileRef = storage.ref().child('media/profile/$filename');
      File imagefile = File(profpic!.path);
      final uploadTask = await profileRef.putFile(imagefile);
      // uploadTask.onProgressChanged((snapshot) => print(
      //     'Upload Progress: ${snapshot.bytesTransferred}/${snapshot.totalBytes}'));
      final downloadurl = await uploadTask.ref.getDownloadURL();
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final CollectionReference users =
            FirebaseFirestore.instance.collection('Users');
        await users.doc(user.uid).update({'profileUrl': downloadurl});
        print('Profile Uploaded');
      } else {
        print('error in uploading');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> savechanges(
      {required String name,
      required String bio,
      required String phone}) async {
    try {
      // final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final CollectionReference users =
            FirebaseFirestore.instance.collection('Users');
        await users
            .doc(user?.uid)
            .update({'name': name, 'bio': bio, 'phone': phone});

        // getUserDetails();
        notifyListeners();

        print('details changed');
      } else {
        print('Something went wrong');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    if (await GoogleSignIn().isSignedIn()) {
      await GoogleSignIn().signOut();
    }
  }

  bool isfolowing = false;
  Future<void> isFollowing(String id) async {
    user = FirebaseAuth.instance.currentUser;
    CollectionReference following = FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.uid)
        .collection('Following');
    final snapshot = await following.doc(id).get();
    snapshot.exists ? isfolowing = true : isfolowing = false;
    notifyListeners();
  }

  Future<void> followUser(String id) async {
    user = FirebaseAuth.instance.currentUser;
    CollectionReference following = FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.uid)
        .collection('Following');
    CollectionReference follower = FirebaseFirestore.instance
        .collection('Users')
        .doc(id)
        .collection('Follower');
    Map<String, dynamic> empdata = {};
    await following.doc(id).set(empdata);
    await follower.doc(user!.uid).set(empdata);
  }

  Future<void> unfollowUser(String id) async {
    user = FirebaseAuth.instance.currentUser;
    CollectionReference following = FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.uid)
        .collection('Following');
    CollectionReference follower = FirebaseFirestore.instance
        .collection('Users')
        .doc(id)
        .collection('Follower');
    await following.doc(id).delete();
    await follower.doc(user!.uid).delete();
  }

  int followingcount = 0, followercount = 0;

  Future<void> FollowCount(String uid) async {
    final following = FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('Following');
    final followers = FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('Follower');
    final followingsnapshot = await following.get();
    final followersnapshot = await followers.get();
    followingcount = followingsnapshot.size;
    followercount = followersnapshot.size;
    notifyListeners();
  }

  Future<List<Map<String, dynamic>>> fetchposts() async {
    final postsRef = FirebaseFirestore.instance.collection('Posts');
    final querySnapshot = await postsRef.get();
    final allposts = querySnapshot.docs.map((QueryDocumentSnapshot doc) {
      final data = doc.data() as Map<String, dynamic>;
      return data;
    }).toList();
    return allposts;
  }
}
