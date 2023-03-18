import 'package:ani_stream/models/episode_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class EpisodeWidget extends StatelessWidget {
  final EpisodeModel ep;

  const EpisodeWidget({super.key, required this.ep});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.bottomCenter,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: CachedNetworkImageProvider(ep.thumbnail),
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
              ep.title.trim(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}
