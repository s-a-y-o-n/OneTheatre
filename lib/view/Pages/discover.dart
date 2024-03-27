import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onetheatre/controller/discovercontroller.dart';
import 'package:onetheatre/model/moviemodel.dart';
import 'package:onetheatre/utils/api_constants.dart';
import 'package:onetheatre/view/Pages/detailsPage.dart';
import 'package:onetheatre/view/Pages/discoversearch.dart';
import 'package:onetheatre/view/widgets/cuscarouselwidget.dart';
import 'package:onetheatre/view/widgets/movielistwidget.dart';
import 'package:provider/provider.dart';

class Explorepage extends StatefulWidget {
  Explorepage({super.key});

  @override
  State<Explorepage> createState() => _ExplorepageState();
}

class _ExplorepageState extends State<Explorepage> {
  late Future<Model> popularMovies, popularTvShows, upcoming;
  Future<void> fetchData() async {
    Provider.of<DiscoverController>(context, listen: false).fetchTrending();
    popularMovies = Provider.of<DiscoverController>(context, listen: false)
        .getPopularMovies();
    popularTvShows = Provider.of<DiscoverController>(context, listen: false)
        .getPopularTvShows();
    upcoming = Provider.of<DiscoverController>(context, listen: false)
        .getUpcomingMovies();
  }

  @override
  void initState() {
    // TODO: implement initState

    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DiscoverController provider = Provider.of<DiscoverController>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      // backgroundColor: Colors.black,
      body: provider.isloading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : CustomScrollView(
              slivers: [
                SliverAppBar(
                  elevation: 0,
                  toolbarHeight: 30,
                  collapsedHeight: 40,
                  floating: true,
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
                                    builder: (context) => DiscoverSearch()));
                          },
                          icon: Icon(
                            Icons.search,
                            // color: Colors.white,
                          )),
                    )
                  ],
                ),
                SliverList(
                    delegate: SliverChildListDelegate([
                  SizedBox(
                    height: 10,
                  ),
                  CarouselSlider.builder(
                    itemCount: provider.tmdbModel.results?.length,
                    itemBuilder: (context, itemIndex, pageViewIndex) {
                      return Carousel_slide(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailsPage(
                                        itemindex: itemIndex,
                                        data: provider.tmdbModel.results,
                                        mediatype: provider.tmdbModel
                                            .results[itemIndex].mediaType!)));
                          },
                          image: NetworkImage(
                              '${ApiConstants.imagePath}${provider.tmdbModel.results?[itemIndex].posterPath}'),
                          title:
                              '${provider.tmdbModel.results?[itemIndex].title ?? provider.tmdbModel.results?[itemIndex].name}',
                          rating:
                              "${provider.tmdbModel.results?[itemIndex].voteAverage?.toStringAsFixed(1)}");
                    },
                    options: CarouselOptions(
                        viewportFraction: 0.56,
                        height: 350,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        autoPlayAnimationDuration: Duration(seconds: 1)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  MovieListWidget(
                      headline: 'Movies',
                      future: popularMovies,
                      mediatype: MediaType.MOVIE),
                  SizedBox(
                    height: 10,
                  ),
                  MovieListWidget(
                    headline: 'TV Shows',
                    future: popularTvShows,
                    mediatype: MediaType.TV,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  MovieListWidget(
                    headline: 'Upcoming',
                    future: upcoming,
                    mediatype: MediaType.MOVIE,
                  )
                ]))
              ],
            ),
    );
  }
}
