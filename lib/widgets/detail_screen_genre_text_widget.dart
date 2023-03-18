import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class DetailScreenGenreTextWidget extends StatelessWidget {
  final List<String> genresList;
  const DetailScreenGenreTextWidget({super.key, required this.genresList});

  @override
  Widget build(BuildContext context) {
    String genres = genresList.toString();
    genres = genres.substring(1, genres.length - 1);
    return Text(genres);
  }
}
