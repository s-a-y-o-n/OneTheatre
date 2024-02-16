import 'package:flutter/material.dart';
import 'package:onetheatre/view/widgets/profilepost.dart';

class Posts extends StatelessWidget {
  const Posts({super.key});

  @override
  Widget build(BuildContext context) {
    // return ListView(
    //   children: List.generate(
    //       5,
    //       (index) => ProfilePostwidget(
    //           image: NetworkImage(
    //               "https://images.unsplash.com/photo-1561227414-a7cd2130328c?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTE1fHxtb3ZpZXxlbnwwfHwwfHx8MA%3D%3D"),
    //           caption: "Favourite film of the year")),
    // );
    return Center(
      child: Text('Posts'),
    );
  }
}
