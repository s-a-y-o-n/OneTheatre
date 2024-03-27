import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onetheatre/controller/profilecontroller.dart';
import 'package:onetheatre/view/Login_and_registration/login.dart';
import 'package:onetheatre/view/Pages/editprofile.dart';
import 'package:onetheatre/view/Pages/tabs/collections.dart';
import 'package:onetheatre/view/widgets/profilepost.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileController>(builder: (context, provider, child) {
      Future<void> followCount(String? userid) async {
        await provider.FollowCount(userid!);
      }

      if (provider.userdata == null) {
        Future.microtask(() => provider.getUserDetails());

        return Center(
          child: CircularProgressIndicator(),
        );
      }
      followCount(provider.userid);

      final user = provider.userdata;

      return DefaultTabController(
        length: 2,
        child: SafeArea(
            child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              user!['name'],
              style: GoogleFonts.salsa(fontSize: 17),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    provider.userdata = null;
                    provider.logout(context);
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  },
                  icon: Icon(Icons.logout))
            ],
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
                                      image: NetworkImage(user['profileUrl'] ==
                                              ''
                                          ? "https://media.istockphoto.com/id/1251464080/vector/people-communication-icon-in-flat-style-people-vector-illustration-on-black-round-background.jpg?s=612x612&w=0&k=20&c=-UIAyz14n25sNlNYqDz7a4_7skVUEhFF4B2pj6vgm4g="
                                          : user['profileUrl']),
                                      fit: BoxFit.cover),
                                  shape: BoxShape.circle),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              user['name'],
                              style: GoogleFonts.salsa(fontSize: 17),
                            ),
                          ),
                          Text(
                            user['bio'] == '' ? "" : user['bio'],
                            maxLines: null,
                            style: GoogleFonts.salsa(fontSize: 16),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => EditProfile()));
                                },
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
                                        '${provider.followercount}',
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
                                        '${provider.followingcount}',
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
                Collections()
              ])),
        )),
      );
    });
  }
}
