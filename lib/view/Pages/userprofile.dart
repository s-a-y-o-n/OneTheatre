import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onetheatre/controller/profilecontroller.dart';
import 'package:onetheatre/utils/constants.dart';
import 'package:onetheatre/view/widgets/profilepost.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatelessWidget {
  Map<String, dynamic> data;
  String uid;
  UserProfile({super.key, required this.data, required this.uid});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileController>(builder: (context, provider, child) {
      Future<void> isFollowing() async {
        await provider.isFollowing(uid);
      }

      Future<void> tooglefollow(String id) async {
        provider.isfolowing
            ? provider.unfollowUser(id)
            : provider.followUser(id);
      }

      Future<void> followCount() async {
        await provider.FollowCount(uid);
      }

      isFollowing();
      followCount();

      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              data['name'],
              style: GoogleFonts.salsa(fontSize: 17),
            ),
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
                                    image: NetworkImage(data['profileUrl'] == ''
                                        ? "https://media.istockphoto.com/id/1251464080/vector/people-communication-icon-in-flat-style-people-vector-illustration-on-black-round-background.jpg?s=612x612&w=0&k=20&c=-UIAyz14n25sNlNYqDz7a4_7skVUEhFF4B2pj6vgm4g="
                                        : data['profileUrl']),
                                    fit: BoxFit.cover),
                                shape: BoxShape.circle),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            data['name'],
                            style: GoogleFonts.salsa(fontSize: 17),
                          ),
                        ),
                        Text(
                          data['bio'] != null ? data['bio'] : '',
                          maxLines: null,
                          style: GoogleFonts.salsa(fontSize: 16),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: ElevatedButton(
                            onPressed: () {
                              tooglefollow(uid);
                            },
                            child: Text(
                              provider.isfolowing ? 'Unfollow' : 'Follow',
                              style: GoogleFonts.salsa(
                                  color: provider.isfolowing
                                      ? Constants.primarycolor
                                      : Colors.white),
                            ),
                            style: provider.isfolowing
                                ? ButtonStyle()
                                : ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Constants.primarycolor)),
                          ),
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
                )
              ];
            },
            body: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ProfilePostwidget(
                      image: NetworkImage(
                          "https://images.unsplash.com/photo-1683009427590-dd987135e66c?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHwxNDF8fHxlbnwwfHx8fHw%3D"),
                      caption:
                          "With its intricate plot, clever twists, and memorable performances, particularly from Kevin Spacey as the enigmatic Verbal Kint, the film has rightfully earned its place as a classic in the genre. The nonlinear storytelling adds depth to the narrative, inviting viewers to piece together the puzzle alongside the characters");
                }),
          ),
        ),
      );
    });
  }
}
