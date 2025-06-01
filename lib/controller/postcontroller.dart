import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:onetheatre/controller/firebase_functions.dart';
import 'package:onetheatre/model/posts.dart';

class PostController extends ChangeNotifier {
  Future<List<Map<String, dynamic>>> fetchPosts() async {
    final snapshot = await FirebaseFirestore.instance.collection('Posts').get();
    // List<Posts> posts;
    // posts = snapshot.docs.map((doc) => Posts.fromSnapshot(doc)).toList();
    // posts = await FireFunctions().getPosts();

    notifyListeners();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }
}
