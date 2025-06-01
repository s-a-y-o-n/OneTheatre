import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:onetheatre/model/posts.dart';

class FireFunctions {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  Future<String?> registeruser(
      {required String name,
      required String email,
      required String phone,
      required String password}) async {
    try {
      final credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final userId = credential.user!.uid;
      final userRef =
          FirebaseFirestore.instance.collection("Users").doc(userId);

      // Create user data map
      final userData = {
        'email': credential.user!.email,
        'name': name,
        'phone': phone,
        'bio': '',
        'profileUrl': ''
      };
      try {
        await userRef.set(userData);
        return null; // Indicate successful registration
      } on FirebaseException catch (e) {
        if (e.code == 'permission-denied') {
          // Handle security rules violation (e.g., insufficient write permissions)
          return 'Write permission denied. Check security rules.';
        } else {
          rethrow; // Rethrow for other FirebaseAuthException errors
        }
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      print(e);
    }
  }

  Future<String?> login(
      {required String email, required String password}) async {
    try {
      final credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<UserCredential?> signinWithGoogle() async {
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      return null;
    }
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    UserCredential userCredential = await auth.signInWithCredential(credential);
    return userCredential;
  }

  Future<bool> isExistingUser(String? uid) async {
    final docRef = FirebaseFirestore.instance.collection('Users').doc(uid);
    final snapshot = await docRef.get();
    return snapshot.exists;
  }

  Future<void> addToUser(User? user) async {
    final docRef =
        FirebaseFirestore.instance.collection('Users').doc(user?.uid);
    final userData = {
      'email': user?.email,
      'name': user?.displayName,
      'phone': '',
      'bio': '',
      'profileUrl': user?.photoURL
    };
    await docRef.set(userData);
  }

  Future<List<Posts>> getPosts() async {
    final snapshot = await FirebaseFirestore.instance.collection('Posts').get();
    return snapshot.docs.map((doc) => Posts.fromSnapshot(doc)).toList();
  }

  Future<String> getUsername(String userid) async {
    final doc =
        await FirebaseFirestore.instance.collection('Users').doc(userid).get();
    if (doc.exists) {
      return doc['name'];
    } else {
      return 'Unknown';
    }
  }
}
