import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onetheatre/controller/discovercontroller.dart';
import 'package:onetheatre/model/detailsmodel.dart';
import 'package:onetheatre/model/moviemodel.dart';
import 'package:onetheatre/model/tvdetailsmodel.dart';
import 'package:onetheatre/utils/api_constants.dart';
import 'package:onetheatre/utils/genres.dart';
import 'package:onetheatre/view/widgets/castwidget.dart';
import 'package:onetheatre/view/widgets/crewwidget.dart';
import 'package:onetheatre/view/widgets/similarwidget.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatelessWidget {
  int? itemindex;
  List<Result>? data;
  DetailsModel? detailData;
  TvDetailModel? tvdetailData;
  MediaType mediatype;
  DetailsPage(
      {super.key,
      this.itemindex,
      this.data,
      this.detailData,
      this.tvdetailData,
      required this.mediatype});
  bool isliked = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<DiscoverController>(builder: (context, provider, child) {
      Future<void> checkLike(List<Result> data) async {
        print('clicked');
        int? id = itemindex != null ? data[itemindex!].id : detailData?.id;
        String mediaType = mediatype == MediaType.MOVIE ? 'movie' : 'tv';
        isliked = await provider.isLiked(id: id, mediatype: mediaType);
        print(isliked);
      }

      Future<void> checkLikeDetail(DetailsModel data) async {
        print('clicked');
        int? id = detailData?.id;
        String mediaType = mediatype == MediaType.MOVIE ? 'movie' : 'tv';
        isliked = await provider.isLiked(id: id, mediatype: mediaType);
        print(isliked);
      }

      Future<void> checkLiketvDetail(TvDetailModel data) async {
        print('clicked');
        int? id = data.id;
        String mediaType = mediatype == MediaType.MOVIE ? 'movie' : 'tv';
        isliked = await provider.isLiked(id: id, mediatype: mediaType);
        print(isliked);
      }

      Future<void> toogleLike(List<Result> data) async {
        print('clicked');
        int? id = itemindex != null ? data[itemindex!].id : detailData?.id;
        String mediaType = mediatype == MediaType.MOVIE ? 'movie' : 'tv';
        String poster =
            '${ApiConstants.imagePath}${data[itemindex!].posterPath}';

        isliked
            ? provider.removeLiked(id: id, mediatype: mediaType)
            : provider.addLiked(id: id, mediatype: mediaType, poster: poster);
      }

      Future<void> toogleLikeDetail(DetailsModel data) async {
        print('clicked');
        int? id = detailData?.id;
        String mediaType = mediatype == MediaType.MOVIE ? 'movie' : 'tv';
        String poster = '${ApiConstants.imagePath}${data.posterPath}';

        isliked
            ? provider.removeLiked(id: id, mediatype: mediaType)
            : provider.addLiked(id: id, mediatype: mediaType, poster: poster);
      }

      Future<void> toogleLiketvDetail(TvDetailModel data) async {
        print('clicked');
        int? id = data.id;
        String mediaType = mediatype == MediaType.MOVIE ? 'movie' : 'tv';
        String poster = '${ApiConstants.imagePath}${data.posterPath}';

        isliked
            ? provider.removeLiked(id: id, mediatype: mediaType)
            : provider.addLiked(id: id, mediatype: mediaType, poster: poster);
      }

      if (data != null) {
        checkLike(data!);
      } else if (detailData != null) {
        checkLikeDetail(detailData!);
      } else {
        checkLiketvDetail(tvdetailData!);
      }

      return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: ImageIcon(AssetImage("assets/images/logo.png")),
        ),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: MediaQuery.of(context).size.height / 1.8,
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: IconButton(
                        onPressed: () {
                          if (data != null) {
                            toogleLike(data!);
                          } else if (detailData != null) {
                            toogleLikeDetail(detailData!);
                          } else {
                            toogleLiketvDetail(tvdetailData!);
                          }
                        },
                        icon: isliked
                            ? Icon(
                                Icons.favorite,
                                color: Colors.red,
                              )
                            : Icon(Icons.favorite)),
                  )
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(
                    data != null
                        ? '${ApiConstants.imagePath}${data![itemindex!].posterPath}'
                        : detailData != null
                            ? '${ApiConstants.imagePath}${detailData?.posterPath}'
                            : '${ApiConstants.imagePath}${tvdetailData?.posterPath}',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SliverList(
                  delegate: SliverChildBuilderDelegate(childCount: 1,
                      (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data != null
                            ? '${data![itemindex!].title ?? data![itemindex!].name}'
                            : detailData != null
                                ? '${detailData!.title}'
                                : '${tvdetailData!.name}',
                        style: GoogleFonts.salsa(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Wrap(
                          children: List.generate(
                              data != null
                                  ? data![itemindex!].genreIds!.length
                                  : detailData != null
                                      ? detailData!.genres!.length
                                      : tvdetailData!.genres!.length, (index) {
                        if (data != null) {
                          return Padding(
                            padding: EdgeInsets.only(right: 10, top: 4),
                            child: Chip(
                                label: Text(
                              Genress()
                                  .getGenres(data![itemindex!].genreIds!)
                                  .split(',')
                                  .elementAt(index),
                              style: GoogleFonts.salsa(),
                            )),
                          );
                        } else if (detailData != null) {
                          return Padding(
                              padding: EdgeInsets.only(right: 10, top: 4),
                              child: Chip(
                                  label: Text(
                                      '${detailData!.genres![index].name}')));
                        } else {
                          return Padding(
                              padding: EdgeInsets.only(right: 10, top: 4),
                              child: Chip(
                                  label: Text(
                                      '${tvdetailData!.genres![index].name}')));
                        }
                      })),
                      SizedBox(height: 7),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Icon(Icons.date_range),
                            Text(
                              data != null
                                  ? '${data![itemindex!].releaseDate?.year ?? data![itemindex!].firstAirDate?.year}'
                                  : detailData != null
                                      ? '${detailData!.releaseDate!.year}'
                                      : '${tvdetailData!.firstAirDate!.year}',
                              style: GoogleFonts.salsa(),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Icon(Icons.star),
                            Text(
                              data != null
                                  ? "${data![itemindex!].voteAverage?.toStringAsFixed(1)}"
                                  : detailData != null
                                      ? '${detailData!.voteAverage?.toStringAsFixed(1)}'
                                      : '${tvdetailData!.voteAverage?.toStringAsFixed(1)}',
                              style: GoogleFonts.salsa(),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Story Line',
                                style: GoogleFonts.salsa(fontSize: 19),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                data != null
                                    ? '${data![itemindex!].overview}'
                                    : detailData != null
                                        ? '${detailData!.overview}'
                                        : '${tvdetailData!.overview}',
                                style: GoogleFonts.salsa(fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      CastWidget(
                        id: data != null
                            ? data![itemindex!].id!
                            : detailData != null
                                ? detailData!.id!
                                : tvdetailData!.id!,
                        mediatype: data?[itemindex!].mediaType ?? mediatype,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CrewWidget(
                          id: data != null
                              ? data![itemindex!].id!
                              : detailData != null
                                  ? detailData!.id!
                                  : tvdetailData!.id!,
                          mediatype: data?[itemindex!].mediaType ?? mediatype),
                      SimilarWidget(
                          id: data != null
                              ? data![itemindex!].id!
                              : detailData != null
                                  ? detailData!.id!
                                  : tvdetailData!.id!,
                          mediatype: data?[itemindex!].mediaType ?? mediatype)
                    ],
                  ),
                );
              }))
            ],
          ),
        ),
      );
    });
  }
}
