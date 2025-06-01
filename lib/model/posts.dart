import 'package:cloud_firestore/cloud_firestore.dart';

class Posts {
  final String content;
  final String? imageurl;
  final String mediatype;
  final String? movieid;
  final String userid;
  final String username;

  Posts(
      {required this.content,
      this.imageurl,
      required this.mediatype,
      required this.userid,
      this.movieid,
      this.username = ''});
  factory Posts.fromSnapshot(DocumentSnapshot doc) {
    return Posts(
        content: doc['content'],
        imageurl: doc['imageurl'],
        mediatype: doc['mediatype'],
        movieid: doc['movieid'],
        userid: doc['userid']);
  }
}
