import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onetheatre/controller/profilecontroller.dart';
import 'package:onetheatre/view/Pages/userprofile.dart';
import 'package:provider/provider.dart';

class UserSearch extends StatefulWidget {
  const UserSearch({super.key});

  @override
  State<UserSearch> createState() => _UserSearchState();
}

class _UserSearchState extends State<UserSearch> {
  String name = '';
  @override
  Widget build(BuildContext context) {
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
                name = value;
              });
            },
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Users').snapshots(),
          builder: (context, snapshot) {
            return (snapshot.connectionState == ConnectionState.waiting)
                ? Center(
                    child: Text('Loading...'),
                  )
                : ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      String? id = snapshot.data!.docs[index].id;
                      var data = snapshot.data!.docs[index].data()
                          as Map<String, dynamic>;
                      if (name.isEmpty) {
                        return Container();
                      }
                      if (data['name']
                          .toString()
                          .toLowerCase()
                          .contains(name.toLowerCase())) {
                        return ListTile(
                          title: Text(
                            data['name'],
                            // overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.salsa(),
                          ),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(data['profileUrl'] ==
                                    ''
                                ? "https://media.istockphoto.com/id/1251464080/vector/people-communication-icon-in-flat-style-people-vector-illustration-on-black-round-background.jpg?s=612x612&w=0&k=20&c=-UIAyz14n25sNlNYqDz7a4_7skVUEhFF4B2pj6vgm4g="
                                : data['profileUrl']),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        UserProfile(data: data, uid: id)));
                          },
                        );
                      } else {
                        return Container();
                      }
                    });
          }),
    );
  }
}
