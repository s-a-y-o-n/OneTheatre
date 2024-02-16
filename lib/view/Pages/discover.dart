import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onetheatre/controller/discovercontroller.dart';
import 'package:onetheatre/utils/api_constants.dart';
import 'package:onetheatre/view/widgets/cuscarouselwidget.dart';
import 'package:provider/provider.dart';

class Explorepage extends StatelessWidget {
  Explorepage({super.key});

  Future<void> fetchData(BuildContext context) async {
    Provider.of<DiscoverController>(context, listen: false).fetchTrending();
  }

  @override
  Widget build(BuildContext context) {
    fetchData(context);
    return Consumer<DiscoverController>(builder: (context, provider, child) {
      return DefaultTabController(
        length: 7,
        initialIndex: 0,
        child: Scaffold(
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
                              onPressed: () {},
                              icon: Icon(
                                Icons.search,
                                // color: Colors.white,
                              )),
                        )
                      ],
                    ),
                    SliverList(
                        delegate: SliverChildListDelegate([
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          'Popular',
                          style: GoogleFonts.salsa(fontSize: 18),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CarouselSlider.builder(
                        itemCount: provider.tmdbModel.results?.length,
                        itemBuilder: (context, itemIndex, pageViewIndex) {
                          return Carousel_slide(
                              onTap: () {},
                              image: NetworkImage(
                                  '${ApiConstants.imagePath}${provider.tmdbModel.results?[itemIndex].posterPath}'),
                              title:
                                  '${provider.tmdbModel.results?[itemIndex].title ?? provider.tmdbModel.results?[itemIndex].name}',
                              rating:
                                  "${provider.tmdbModel.results?[itemIndex].voteAverage}");
                        },
                        options: CarouselOptions(
                            viewportFraction: 0.56,
                            height: 350,
                            autoPlay: true,
                            enlargeCenterPage: true,
                            autoPlayCurve: Curves.fastOutSlowIn,
                            autoPlayAnimationDuration: Duration(seconds: 1)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          'For You',
                          style: GoogleFonts.salsa(
                              textStyle: TextStyle(
                            fontSize: 20,
                          )),
                        ),
                      ),
                      TabBar(
                        isScrollable: true,
                        dividerHeight: 0,
                        padding: EdgeInsets.all(10),
                        labelColor: Color.fromARGB(255, 8, 182, 182),
                        tabs: List.generate(
                            7,
                            (index) => Tab(
                                  text: "Category",
                                )),
                        labelStyle: GoogleFonts.salsa(),
                      ),
                      SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                                10,
                                (index) => Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Card(
                                        child: Container(
                                          height: 200,
                                          width: 150,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      "https://imgc.allpostersimages.com/img/posters/john-wick_u-L-F7SH250.jpg"),
                                                  fit: BoxFit.fill)),
                                        ),
                                      ),
                                    )),
                          ))
                    ]))
                  ],
                ),
        ),
      );
    });
  }
}
