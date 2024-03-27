import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onetheatre/controller/discovercontroller.dart';
import 'package:onetheatre/model/moviemodel.dart';
import 'package:onetheatre/utils/api_constants.dart';
import 'package:onetheatre/utils/constants.dart';
import 'package:onetheatre/view/Pages/detailsPage.dart';
import 'package:provider/provider.dart';

class DiscoverSearch extends StatefulWidget {
  const DiscoverSearch({super.key});

  @override
  State<DiscoverSearch> createState() => _DiscoverSearchState();
}

class _DiscoverSearchState extends State<DiscoverSearch> {
  String query = '';
  @override
  Widget build(BuildContext context) {
    return Consumer<DiscoverController>(builder: (context, provider, child) {
      return Scaffold(
        appBar: AppBar(
          title: Container(
            child: TextField(
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Search',
                  hintStyle: GoogleFonts.salsa(),
                  contentPadding: EdgeInsets.all(5),
                  filled: true,
                  fillColor: Colors.white10,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: BorderSide.none)),
              onChanged: (value) {
                setState(() {
                  query = value;
                });
              },
            ),
          ),
        ),
        body: DefaultTabController(
          length: 2,
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    height: 40,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(25)),
                    child: TabBar(
                      tabs: [
                        Tab(
                          text: 'Movies',
                        ),
                        Tab(
                          text: 'Series',
                        )
                      ],
                      indicatorSize: TabBarIndicatorSize.tab,
                      dividerHeight: 0,
                      indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Constants.primarycolor),
                      labelStyle: GoogleFonts.salsa(),
                      labelColor: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                    child: TabBarView(children: [
                  FutureBuilder<Model>(
                      future: provider.Moviesearch(query),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasData) {
                          final data = snapshot.data?.results;
                          return ListView.builder(
                              itemCount: data?.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => DetailsPage(
                                                    mediatype: MediaType.MOVIE,
                                                    data: data,
                                                    itemindex: index,
                                                  )));
                                    },
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.grey,
                                      backgroundImage: NetworkImage(
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
                  FutureBuilder<Model>(
                      future: provider.Seriessearch(query),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasData) {
                          final data = snapshot.data?.results;
                          return ListView.builder(
                              itemCount: data?.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => DetailsPage(
                                                    mediatype: MediaType.MOVIE,
                                                    data: data,
                                                    itemindex: index,
                                                  )));
                                    },
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.grey,
                                      backgroundImage: NetworkImage(
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
                ]))
              ],
            ),
          ),
        ),
      );
    });
  }
}
