import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onetheatre/controller/profilecontroller.dart';
import 'package:onetheatre/utils/constants.dart';
import 'package:onetheatre/view/Pages/createpost.dart';
import 'package:onetheatre/view/Pages/usersearch.dart';
import 'package:onetheatre/view/widgets/postwidget.dart';
import 'package:provider/provider.dart';

class Homepage extends StatelessWidget {
  Homepage({super.key});
  List<Map<String, dynamic>>? posts;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Constants.primarycolor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CreatePost()));
            },
            icon: Icon(
              Icons.add,
              size: 30,
              color: Colors.white,
            )),
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
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('Posts').snapshots(),
            builder: (context, snapshot) {
              return (snapshot.connectionState == ConnectionState.waiting)
                  ? Center(
                      child: Text('Loading...'),
                    )
                  : ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var data = snapshot.data!.docs[index].data()
                            as Map<String, dynamic>;
                        return Postwidget(
                            Userid: data['uid'],
                            profileimage: NetworkImage(
                                "https://images.unsplash.com/photo-1706648568426-66c073d7de5c?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyOXx8fGVufDB8fHx8fA%3D%3D"),
                            image: NetworkImage(data['imageurl']),
                            caption: data['content']);
                      },
                    );
            })

        // FutureBuilder(
        //   future: posts,
        //   builder: (context, snapshot) {
        //     if (snapshot.hasData) {
        //       final postss = snapshot.data!;
        //       return ListView.builder(
        //         itemCount: postss.length,
        //         itemBuilder: (context, index) {
        //           return Postwidget(
        //               Userid: postss[index]['uid'],
        //               profileimage: NetworkImage(
        //                   "https://images.unsplash.com/photo-1706648568426-66c073d7de5c?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyOXx8fGVufDB8fHx8fA%3D%3D"),
        //               image: NetworkImage(postss[index]['imageurl']),
        //               caption: postss[index]['content']);
        //         },
        //       );
        //     } else if (snapshot.hasError) {
        //       return Center(child: CircularProgressIndicator());
        //     }
        //     return Center(child: CircularProgressIndicator());
        //   },
        // )
        ,
      ),
    );
  }
}
