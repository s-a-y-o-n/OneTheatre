import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:onetheatre/model/moviemodel.dart';

class DiscoverController with ChangeNotifier {
  late MovieModel tmdbModel;
  bool isloading = false;
  static const trendingUrl =
      'https://api.themoviedb.org/3/trending/all/day?api_key=0291e034fd09947fce0e4c255ecbb346';
  fetchTrending() async {
    isloading = true;
    notifyListeners();
    final url = Uri.parse(trendingUrl);
    final response = await http.get(url);
    Map<String, dynamic> decodedData = {};
    if (response.statusCode == 200) {
      decodedData = jsonDecode(response.body);
    } else {
      print("Api Failed");
    }
    tmdbModel = MovieModel.fromJson(decodedData);
    isloading = false;
    notifyListeners();
  }
}
