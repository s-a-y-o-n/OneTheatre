import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onetheatre/controller/discovercontroller.dart';
import 'package:provider/provider.dart';

class PostWidget extends StatelessWidget {
  final String content;
  final String? imageurl;
  final String username;
  final String? mediatype;
  final String? movieid;
  PostWidget(
      {required this.content,
      this.imageurl,
      required this.username,
      this.mediatype,
      this.movieid});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://images.unsplash.com/photo-1694564717876-7436bdf6a236?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDE0NHxTNE1LTEFzQkI3NHx8ZW58MHx8fHx8"),
              maxRadius: 13,
            ),
            title: Text(
              username,
              style: GoogleFonts.salsa(
                fontSize: 15,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              content,
              style: GoogleFonts.salsa(fontSize: 17),
            ),
          ),
          (imageurl != "")
              ? Container(
                  width: double.infinity,
                  height: 500,
                  child: CachedNetworkImage(
                    imageUrl: imageurl!,
                    placeholder: (context, url) => Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.black54, Colors.transparent])),
                    ),
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover)),
                      );
                    },
                  ),
                )
              : SizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.favorite,
                  ),
                  label: Text(
                    '232',
                    style: GoogleFonts.salsa(),
                  )),
              TextButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.mode_comment,
                  ),
                  label: Text('122', style: GoogleFonts.salsa())),
            ],
          )
        ],
      ),
    );
  }
}
