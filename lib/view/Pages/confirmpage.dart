import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onetheatre/model/moviemodel.dart';
import 'package:onetheatre/utils/api_constants.dart';
import 'package:onetheatre/utils/constants.dart';
import 'package:onetheatre/view/Pages/navigationbar.dart';

class Confirmpage extends StatelessWidget {
  String content;
  File? image;
  Result? movieref;

  Confirmpage({super.key, required this.content, this.image, this.movieref});
  Future<void> postit(
      {String? content,
      int? movieid,
      MediaType? mediatype,
      File? image}) async {
    String? imageurl;
    String? media;
    if (mediatype == MediaType.MOVIE) {
      media = 'movie';
    } else {
      media = 'tv';
    }
    if (image != null) {
      imageurl = await uploadimage(image);
    } else {
      imageurl = '';
    }
    final timestamp = FieldValue.serverTimestamp();
    User? currentuser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    String uid = currentuser!.uid;
    CollectionReference Postsref = firestore.collection('Posts');
    final data = {
      'uid': uid,
      'content': content,
      'timestamp': timestamp,
      'imageurl': imageurl,
      'movieid': movieid,
      'mediatype': media
    };
    await Postsref.add(data);
  }

  Future<String> uploadimage(File image) async {
    final postref = FirebaseStorage.instance
        .ref()
        .child('media/posts/${DateTime.now().millisecondsSinceEpoch}.jpg');
    final uploadtask = await postref.putFile(image);
    final downloadurl = await uploadtask.ref.getDownloadURL();
    return downloadurl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
                onPressed: () {
                  postit(
                      content: content,
                      movieid: movieref?.id,
                      mediatype: movieref?.mediaType,
                      image: image);
                  showDialog(
                      barrierColor: Colors.transparent,
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Post Created'),
                          backgroundColor: Color.fromARGB(255, 2, 118, 118),
                          titleTextStyle: GoogleFonts.salsa(fontSize: 20),
                          icon: Icon(
                            Icons.celebration_rounded,
                            size: 60,
                          ),
                          iconColor: const Color.fromARGB(255, 246, 246, 246),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => BotNavbar()));
                                },
                                child: Text(
                                  'OK',
                                  style: GoogleFonts.salsa(
                                      color: Constants.seccolor),
                                ))
                          ],
                        );
                      });
                },
                icon: Icon(
                  Icons.done,
                )),
          )
        ],
      ),
      body: SafeArea(
          child: Column(
        children: [
          image != null
              ? Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    height: 300,
                    width: 300,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: FileImage(image!), fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(20)),
                  ),
                )
              : Container(),
          movieref != null
              ? Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    height: 60,
                    width: 200,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(15)),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey,
                        backgroundImage: NetworkImage(
                            '${ApiConstants.imagePath}${movieref?.posterPath}'),
                        radius: 20,
                      ),
                      title: Text('${movieref?.title ?? movieref?.name}'),
                    ),
                  ),
                )
              : Container(),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              child: Text(
                content,
                textAlign: TextAlign.justify,
                style: GoogleFonts.salsa(),
              ),
            ),
          )
        ],
      )),
    );
  }
}
