import 'package:flutter/material.dart';
import 'package:onetheatre/controller/discovercontroller.dart';
import 'package:onetheatre/model/moviemodel.dart';
import 'package:onetheatre/view/widgets/movielistwidget.dart';
import 'package:provider/provider.dart';

class SimilarWidget extends StatelessWidget {
  int id;
  MediaType mediatype;
  SimilarWidget({super.key, required this.id, required this.mediatype});

  @override
  Widget build(BuildContext context) {
    return Consumer<DiscoverController>(builder: (context, provider, child) {
      final future = provider.getSimilar(id, mediatype);

      return MovieListWidget(
        headline: 'Similar',
        future: future,
        mediatype: mediatype,
      );
    });
  }
}
