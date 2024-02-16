import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onetheatre/view/widgets/profilepost.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              'Username',
              style: GoogleFonts.salsa(fontSize: 17),
            ),
            actions: [IconButton(onPressed: () {}, icon: Icon(Icons.settings))],
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            forceMaterialTransparency: true,
            elevation: 0,
          ),
          body: NestedScrollView(
              headerSliverBuilder: (context, innerboxisscrolable) {
                return [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    pinned: true,
                    floating: true,
                    expandedHeight: 380,
                    surfaceTintColor: Colors.transparent,
                    flexibleSpace: Padding(
                      padding: EdgeInsets.all(15),
                      child: ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 280),
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          "https://media.gettyimages.com/id/459287470/photo/london-england-jim-carrey-attends-a-photocall-for-dumb-and-dumber-to-on-november-20-2014-in.jpg?s=612x612&w=0&k=20&c=HsvA6c9MRcPONox9ny7ZEN_IQ-3-_lGo5BVNwzc6Wvg="),
                                      fit: BoxFit.cover),
                                  shape: BoxShape.circle),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              'Name',
                              style: GoogleFonts.salsa(fontSize: 17),
                            ),
                          ),
                          Text(
                            "Film critic, I write about movies and TV shows",
                            maxLines: null,
                            style: GoogleFonts.salsa(fontSize: 16),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: ElevatedButton(
                                onPressed: () {},
                                child: Text(
                                  'Edit Profile',
                                  style: GoogleFonts.salsa(),
                                )),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Card(
                                elevation: 15,
                                child: Container(
                                  height: 60,
                                  width: 100,
                                  child: Column(
                                    children: [
                                      Text(
                                        '121',
                                        style: GoogleFonts.salsa(fontSize: 20),
                                      ),
                                      Text(
                                        'Posts',
                                        style: GoogleFonts.salsa(fontSize: 16),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Card(
                                elevation: 15,
                                child: Container(
                                  height: 60,
                                  width: 100,
                                  child: Column(
                                    children: [
                                      Text(
                                        '221',
                                        style: GoogleFonts.salsa(fontSize: 20),
                                      ),
                                      Text(
                                        'Followers',
                                        style: GoogleFonts.salsa(fontSize: 16),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Card(
                                elevation: 15,
                                child: Container(
                                  height: 60,
                                  width: 100,
                                  child: Column(
                                    children: [
                                      Text(
                                        '222',
                                        style: GoogleFonts.salsa(fontSize: 20),
                                      ),
                                      Text(
                                        'Following',
                                        style: GoogleFonts.salsa(fontSize: 16),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    bottom: AppBar(
                      surfaceTintColor: Colors.transparent,
                      automaticallyImplyLeading: false,
                      title: TabBar(
                        tabs: [
                          Tab(
                            text: 'Posts',
                          ),
                          Tab(
                            text: 'Collections',
                          )
                        ],
                        labelStyle: GoogleFonts.salsa(),
                      ),
                    ),
                  )
                ];
              },
              body: TabBarView(children: [
                ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return ProfilePostwidget(
                          image: NetworkImage(
                              "https://images.unsplash.com/photo-1683009427590-dd987135e66c?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHwxNDF8fHxlbnwwfHx8fHw%3D"),
                          caption:
                              "With its intricate plot, clever twists, and memorable performances, particularly from Kevin Spacey as the enigmatic Verbal Kint, the film has rightfully earned its place as a classic in the genre. The nonlinear storytelling adds depth to the narrative, inviting viewers to piece together the puzzle alongside the characters");
                    }),
                Column(
                  children: [
                    Center(
                      child: Text("Collection"),
                    )
                  ],
                )
              ])),
        ),
      ),
    );
  }
}
