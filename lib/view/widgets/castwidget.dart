import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onetheatre/controller/discovercontroller.dart';
import 'package:onetheatre/model/moviemodel.dart';
import 'package:onetheatre/utils/api_constants.dart';
import 'package:provider/provider.dart';

class CastWidget extends StatelessWidget {
  int id;
  MediaType mediatype;

  CastWidget({
    super.key,
    required this.id,
    required this.mediatype,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<DiscoverController>(builder: (context, provider, child) {
      provider.getCredit(id, mediatype);

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Casts',
            style: GoogleFonts.salsa(fontSize: 18),
          ),
          provider.creditloading
              ? CircularProgressIndicator()
              : AspectRatio(
                  aspectRatio: 2.1,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: provider.credits.cast?.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.all(5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.grey,
                                radius: 40,
                                child: ClipOval(
                                  child: FadeInImage(
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    placeholder: NetworkImage(
                                        "http://www.familylore.org/images/2/25/UnknownPerson.png"),
                                    image: NetworkImage(
                                        '${ApiConstants.imagePath}${provider.credits.cast?[index].profilePath}'),
                                    imageErrorBuilder:
                                        (context, error, stackTrace) {
                                      return Image.network(
                                          'http://www.familylore.org/images/2/25/UnknownPerson.png');
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                  width: 100,
                                  height: 70,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${provider.credits.cast?[index].name}',
                                        style: GoogleFonts.salsa(fontSize: 15),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        '${provider.credits.cast?[index].character}',
                                        style: GoogleFonts.salsa(
                                          fontSize: 10,
                                        ),
                                        textAlign: TextAlign.center,
                                      )
                                    ],
                                  )),
                            ],
                          ),
                        );
                      }),
                )
        ],
      );
    });
  }
}
