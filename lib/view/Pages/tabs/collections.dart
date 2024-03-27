import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:onetheatre/controller/discovercontroller.dart';
import 'package:onetheatre/model/detailsmodel.dart';
import 'package:onetheatre/model/moviemodel.dart';
import 'package:onetheatre/model/tvdetailsmodel.dart';
import 'package:onetheatre/view/Pages/detailsPage.dart';
import 'package:provider/provider.dart';

class Collections extends StatelessWidget {
  Collections({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DiscoverController>(builder: (context, provider, child) {
      // List<Map<String, dynamic>>? data;
      Future<void> fetchliked() async {
        await provider.fetchLiked();
      }

      fetchliked();
      if (provider.data != null) {
        return GridView.builder(
            itemCount: provider.data!.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                childAspectRatio: 0.7),
            itemBuilder: (context, index) {
              return InkWell(
                  onTap: () async {
                    DetailsModel? details;
                    TvDetailModel? tvdetails;
                    if (provider.data![index]['mediaType'] == 'movie') {
                      details = await provider.likedData(
                          id: provider.data![index]['id'],
                          mediatype: provider.data![index]['mediaType']);
                    } else {
                      tvdetails = await provider.likedtvData(
                          id: provider.data![index]['id'],
                          mediatype: provider.data![index]['mediaType']);
                    }

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailsPage(
                                detailData: details,
                                tvdetailData: tvdetails,
                                mediatype: provider.data![index]['mediaType'] ==
                                        'movie'
                                    ? MediaType.MOVIE
                                    : MediaType.TV)));
                  },
                  child: CachedNetworkImage(
                    imageUrl: '${provider.data![index]['poster']}',
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
                  ));
            });
      } else {
        return Center(
          child: Text('Nothing in the collection'),
        );
      }
    });
  }
}
