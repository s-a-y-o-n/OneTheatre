import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onetheatre/controller/discovercontroller.dart';
import 'package:onetheatre/model/moviemodel.dart';
import 'package:onetheatre/utils/api_constants.dart';
import 'package:onetheatre/utils/constants.dart';
import 'package:onetheatre/view/Pages/confirmpage.dart';
import 'package:provider/provider.dart';

class CreatePost extends StatefulWidget {
  CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  var contentctrl = TextEditingController();
  File? imagefile;
  String query = '';
  Result? moviedata;

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imagefile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DiscoverController>(builder: (context, provider, child) {
      return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 6.5,
                    ),
                    Text(
                      'New Post',
                      style: GoogleFonts.salsa(fontSize: 20),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (contentctrl.text.isEmpty) {
                          showDialog(
                              barrierColor: Colors.transparent,
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Write Someting Before You Go'),
                                  backgroundColor:
                                      Color.fromARGB(255, 2, 118, 118),
                                  titleTextStyle:
                                      GoogleFonts.salsa(fontSize: 20),
                                  icon: Icon(
                                    Icons.cancel_outlined,
                                    size: 60,
                                  ),
                                  iconColor: Colors.red,
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'OK',
                                          style: GoogleFonts.salsa(
                                              color: Constants.seccolor),
                                        ))
                                  ],
                                );
                              });
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Confirmpage(
                                      content: contentctrl.text,
                                      image: imagefile,
                                      movieref: moviedata)));
                        }
                      },
                      child: Text(
                        'Post',
                        style: GoogleFonts.salsa(color: Colors.white),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Constants.primarycolor)),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 750,
                  width: 400,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey)),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            maxLines: null,
                            style: GoogleFonts.salsa(),
                            controller: contentctrl,
                            decoration: InputDecoration(
                                hintText: 'Write Something..',
                                hintStyle: GoogleFonts.salsa(),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none)),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          moviedata != null
                              ? Stack(
                                  children: [
                                    Container(
                                      height: 60,
                                      width: 200,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          backgroundColor: Colors.grey,
                                          backgroundImage: NetworkImage(
                                              '${ApiConstants.imagePath}${moviedata?.posterPath}'),
                                          radius: 20,
                                        ),
                                        title: Text(
                                            '${moviedata?.title ?? moviedata?.name}'),
                                      ),
                                    ),
                                    Positioned(
                                      right: 5,
                                      top: 5,
                                      child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              moviedata = null;
                                            });
                                          },
                                          icon: Icon(
                                            Icons.cancel,
                                            size: 25,
                                          )),
                                    )
                                  ],
                                )
                              : Container(),
                          SizedBox(
                            height: 10,
                          ),
                          imagefile != null
                              ? Stack(children: [
                                  Container(
                                    height: 450,
                                    width: 400,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.file(
                                        imagefile!,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            imagefile = null;
                                          });
                                        },
                                        icon: Icon(
                                          Icons.cancel,
                                          size: 25,
                                        )),
                                    right: 5,
                                    top: 5,
                                  )
                                ])
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap: () {
                          pickImage();
                        },
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.grey,
                          child: Icon(
                            Icons.image,
                            color: Colors.white,
                            size: 30,
                          ),
                        )),
                    SizedBox(
                      width: 25,
                    ),
                    InkWell(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Column(
                                  children: [
                                    Container(
                                      child: TextField(
                                        decoration: InputDecoration(
                                            prefixIcon: Icon(Icons.search),
                                            hintText: 'Search',
                                            hintStyle: GoogleFonts.salsa(),
                                            contentPadding: EdgeInsets.all(5),
                                            filled: true,
                                            fillColor: Colors.white10,
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(40),
                                                borderSide: BorderSide.none)),
                                        onChanged: (value) {
                                          setState(() {
                                            query = value;
                                          });
                                        },
                                      ),
                                    ),
                                    Container(
                                      height: 400,
                                      child: FutureBuilder<Model>(
                                          future: provider.Moviesearch(query),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            } else if (snapshot.hasData) {
                                              final data =
                                                  snapshot.data?.results;
                                              return ListView.builder(
                                                  itemCount: data?.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      child: ListTile(
                                                        onTap: () {
                                                          setState(() {
                                                            moviedata =
                                                                data?[index];
                                                            query = '';
                                                          });

                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        leading: CircleAvatar(
                                                          backgroundColor:
                                                              Colors.grey,
                                                          backgroundImage:
                                                              NetworkImage(
                                                                  '${ApiConstants.imagePath}${data?[index].posterPath}'),
                                                          radius: 30,
                                                        ),
                                                        title: Text(
                                                            '${data?[index].name ?? data?[index].title}'),
                                                      ),
                                                    );
                                                  });
                                            } else if (query.isEmpty) {
                                              return const SizedBox();
                                            } else {
                                              return const Center(
                                                child: Text('Not Found'),
                                              );
                                            }
                                          }),
                                    ),
                                  ],
                                );
                              });
                        },
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.grey,
                          child: Icon(
                            Icons.movie_filter_outlined,
                            color: Colors.white,
                            size: 30,
                          ),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
