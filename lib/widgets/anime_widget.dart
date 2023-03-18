import 'package:ani_stream/models/anime_model.dart';
import 'package:ani_stream/widgets/score_widget.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AnimeCard extends StatelessWidget {
  final Anime anime;
  final void Function()? callback;
  const AnimeCard({super.key, required this.anime, this.callback});

  @override
  Widget build(BuildContext context) {
    late final TextTheme _textTheme = Theme.of(context).textTheme;
    late final ColorScheme _colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: callback,
      child: SizedBox(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              clipBehavior: Clip.hardEdge,
              child: CachedNetworkImage(
                imageUrl: anime.coverImage,
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(5.0),
              alignment: Alignment.bottomCenter,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    Colors.transparent,
                    Color.fromARGB(38, 0, 0, 0),
                    Color.fromARGB(127, 0, 0, 0),
                  ],
                ),
              ),
              child: Text(
                anime.engTitle,
                maxLines: 1,
                style: _textTheme.bodyMedium!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            Positioned(
              top: 6,
              left: 8,
              child: ScoreWidget(
                bgColor: const Color(0xFF2eb44d),
                score: anime.averageScore,
                textStyle: _textTheme.labelLarge,
              ),
            )
          ],
        ),
      ),
    );
  }
}
