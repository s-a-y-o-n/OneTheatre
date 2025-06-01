import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onetheatre/controller/discovercontroller.dart';
import 'package:onetheatre/controller/firebase_functions.dart';
import 'package:onetheatre/controller/postcontroller.dart';
import 'package:onetheatre/controller/profilecontroller.dart';
import 'package:onetheatre/model/posts.dart';
import 'package:onetheatre/utils/constants.dart';
import 'package:onetheatre/view/Pages/createpost.dart';
import 'package:onetheatre/view/Pages/usersearch.dart';
import 'package:onetheatre/view/widgets/postwidget.dart';
import 'package:provider/provider.dart';

class Homepage extends StatelessWidget {
  Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    // final postProvider = Provider.of<PostController>(context);
    List<Map<String, dynamic>> pp = [];
    Future<void> fetchall() async {
      pp = await Provider.of<PostController>(context).fetchPosts();
      print(pp.length);
    }

    fetchall();
    return Consumer<PostController>(builder: (context, provider, child) {
      var p = provider.fetchPosts();

      return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => CreatePost()));
          },
          backgroundColor: Constants.primarycolor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          child: Icon(
            Icons.add,
            size: 30,
            color: Colors.white,
          ),
        ),
        body: NestedScrollView(
            headerSliverBuilder: (context, innerboxisscrolable) {
              return [
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  title: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: 'One',
                        style: GoogleFonts.salsa(
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold))),
                    TextSpan(
                        text: 'Theatre',
                        style: GoogleFonts.salsa(
                            textStyle: TextStyle(
                                color: Color.fromARGB(255, 8, 182, 182),
                                fontSize: 24,
                                fontWeight: FontWeight.bold)))
                  ])),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserSearch()));
                          },
                          icon: Icon(
                            Icons.search,
                            color: Colors.white,
                          )),
                    )
                  ],
                ),
              ];
            },
            body: FutureBuilder(
                future: p,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                          final post = snapshot.data?[index];

                          return FutureBuilder<String>(
                              future: FireFunctions().getUsername(post?['uid']),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return PostWidget(
                                      content: post?['content'],
                                      imageurl: post?['imageurl'],
                                      username: snapshot.data!,
                                      mediatype: post?['mediatype'],
                                      movieid: post?['movieid']);
                                } else {
                                  return SizedBox();
                                }
                              });
                        });
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                })),
      );
    });
  }
}
