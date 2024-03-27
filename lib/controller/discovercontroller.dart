import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:onetheatre/model/creditmodel.dart';
import 'package:onetheatre/model/detailsmodel.dart';

import 'package:onetheatre/model/moviemodel.dart';
import 'package:onetheatre/model/tvdetailsmodel.dart';
// import 'package:onetheatre/model/similarmodel.dart';

class DiscoverController with ChangeNotifier {
  late Model tmdbModel;
  late CreditModel credits;
  // late MovieModel similar;

  bool isloading = true;
  bool creditloading = true;
  bool similarloading = true;
  bool? isliked;

  static const baseurl = 'https://api.themoviedb.org/3/';
  late String endpoint;
  static const key = '?api_key=0291e034fd09947fce0e4c255ecbb346';

  fetchTrending() async {
    // isloading = true;
    // notifyListeners();
    endpoint = 'trending/all/day';
    final uri = '$baseurl$endpoint$key';
    final url = Uri.parse(uri);
    final response = await http.get(url);
    Map<String, dynamic> decodedData = {};
    if (response.statusCode == 200) {
      decodedData = jsonDecode(response.body);
    } else {
      print("Api Failed");
    }
    tmdbModel = Model.fromJson(decodedData);
    // fetchgenre();
    isloading = false;
    notifyListeners();
  }

  Future<void> getCredit(int id, MediaType mediaType) async {
    endpoint =
        mediaType == MediaType.MOVIE ? 'movie/$id/credits' : 'tv/$id/credits';
    final uri = '$baseurl$endpoint$key';
    final url = Uri.parse(uri);
    final response = await http.get(url);
    Map<String, dynamic> decodedData = {};
    if (response.statusCode == 200) {
      decodedData = jsonDecode(response.body);
    } else {
      print('failed to load credit');
    }
    credits = CreditModel.fromJson(decodedData);
    creditloading = false;
    notifyListeners();
  }

  Future<Model> getSimilar(int id, MediaType mediaType) async {
    endpoint =
        mediaType == MediaType.MOVIE ? 'movie/$id/similar' : 'tv/$id/similar';
    final uri = '$baseurl$endpoint$key';
    final url = Uri.parse(uri);
    final response = await http.get(url);
    Map<String, dynamic> decodedData = {};
    if (response.statusCode == 200) {
      decodedData = jsonDecode(response.body);
      print('$baseurl$endpoint$key');
    } else {
      print('failed to load similar');
    }
    return Model.fromJson(decodedData);
  }

  Future<Model> getPopularMovies() async {
    endpoint = 'movie/popular';
    final url = '$baseurl$endpoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return modelFromJson(response.body);
    } else {
      throw Exception('failed to load popular');
    }
  }

  Future<Model> getPopularTvShows() async {
    endpoint = 'tv/popular';
    final url = '$baseurl$endpoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return modelFromJson(response.body);
    } else {
      throw Exception('failed to load popular');
    }
  }

  Future<Model> getUpcomingMovies() async {
    endpoint = 'movie/upcoming';
    final url = '$baseurl$endpoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return modelFromJson(response.body);
    } else {
      throw Exception('failed to load trending');
    }
  }

  Future<bool> isLiked({int? id, required String mediatype}) async {
    final currentuser = FirebaseAuth.instance.currentUser;
    final firestore = FirebaseFirestore.instance;
    final likedmovieref = firestore
        .collection('Users')
        .doc(currentuser!.uid)
        .collection('LikedMovies');
    final snapshot = await likedmovieref.where('id', isEqualTo: '$id').get();
    print(snapshot.docs.any((doc) => doc.data()['mediaType'] == mediatype));
    return snapshot.docs.any((doc) => doc.data()['mediaType'] == mediatype);
  }

  Future<void> addLiked(
      {int? id, required String mediatype, required String poster}) async {
    User? currentuser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference likedmovieref = firestore
        .collection('Users')
        .doc(currentuser!.uid)
        .collection('LikedMovies');
    final data = {'id': '$id', 'mediaType': mediatype, 'poster': poster};
    await likedmovieref.add(data);
  }

  Future<void> removeLiked({int? id, required String mediatype}) async {
    User? currentuser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference likedmovieref = firestore
        .collection('Users')
        .doc(currentuser!.uid)
        .collection('LikedMovies');
    final snapshot = await likedmovieref
        .where('id', isEqualTo: '$id')
        .where('mediaType', isEqualTo: mediatype)
        .get();

    if (snapshot.docs.isNotEmpty) {
      for (final doc in snapshot.docs) {
        await doc.reference.delete();
      }
    }
  }

  List<Map<String, dynamic>>? data;
  Future<void> fetchLiked() async {
    User? currentuser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference likedmovieref = firestore
        .collection('Users')
        .doc(currentuser!.uid)
        .collection('LikedMovies');
    final snapshot = await likedmovieref.get();
    data = snapshot.docs.map((e) => e.data() as Map<String, dynamic>).toList();
    notifyListeners();
  }

  Future<DetailsModel> likedData(
      {required String id, required String mediatype}) async {
    endpoint = 'movie/$id';
    final url = '$baseurl$endpoint$key';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return detailsModelFromJson(response.body);
    } else {
      throw Exception('Failed to load details');
    }
  }

  Future<TvDetailModel> likedtvData({required id, required mediatype}) async {
    endpoint = 'tv/$id';
    final url = '$baseurl$endpoint$key';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return tvDetailModelFromJson(response.body);
    } else {
      throw Exception('Failed to load details');
    }
  }

  String query = '';
  Future<void> SetQuery(String value) async {
    query = value;
    notifyListeners();
  }

  Future<Model> Moviesearch(String queryy) async {
    endpoint = 'search/movie';
    final url = '$baseurl$endpoint$key&query=$queryy';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return modelFromJson(response.body);
    } else {
      throw Exception('Not found');
    }
  }

  Future<Model> Seriessearch(String queryy) async {
    endpoint = 'search/tv';
    final url = '$baseurl$endpoint$key&query=$queryy';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return modelFromJson(response.body);
    } else {
      throw Exception('Not found');
    }
  }
}
