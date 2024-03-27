import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onetheatre/model/moviemodel.dart';
// import 'package:onetheatre/model/similarmodel.dart';
import 'package:onetheatre/utils/api_constants.dart';
import 'package:onetheatre/view/Pages/detailsPage.dart';

class MovieListWidget extends StatelessWidget {
  final String headline;
  Future<Model> future;
  MediaType mediatype;
  MovieListWidget(
      {super.key,
      required this.headline,
      required this.future,
      required this.mediatype});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Model>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data?.results;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    headline,
                    style: GoogleFonts.salsa(fontSize: 21),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 310,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: data?.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 3),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DetailsPage(
                                                  itemindex: index,
                                                  data: data!,
                                                  mediatype:
                                                      data[index].mediaType ??
                                                          mediatype,
                                                )));
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                      '${ApiConstants.imagePath}${data?[index].posterPath}',
                                      height: 240,
                                      width: 170,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  width: 170,
                                  height: 50,
                                  margin: EdgeInsets.only(left: 5),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${data?[index].title ?? data?[index].name}',
                                        style: GoogleFonts.salsa(fontSize: 15),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                  )
                ],
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        });
  }
}
