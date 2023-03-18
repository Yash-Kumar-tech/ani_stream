import 'dart:ui';

import 'package:ani_stream/models/character.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CharacterWidget extends StatelessWidget {
  final Character char;
  const CharacterWidget({super.key, required this.char});

  @override
  Widget build(BuildContext context) {
    // return Container(
    //     clipBehavior: Clip.hardEdge,
    //     decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(16.0),
    //       image: DecorationImage(
    //         image: CachedNetworkImageProvider(char.imageUrl),
    //         fit: BoxFit.cover,
    //       ),
    //     ),
    //     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    //     child: ClipRRect());
    return Container(
      alignment: Alignment.bottomCenter,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: CachedNetworkImageProvider(char.imageUrl),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Container(
        width: 150,
        padding: const EdgeInsets.all(5.0),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              Colors.transparent,
              Color.fromARGB(64, 0, 0, 0),
              Color.fromARGB(127, 0, 0, 0),
              Color.fromARGB(200, 0, 0, 0),
            ],
          ),
        ),
        child: Text(
          char.fullName,
          maxLines: 2,
        ),
      ),
    );
  }
}
