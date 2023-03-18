import 'dart:math';
import 'dart:ui';

import 'package:ani_stream/models/anime_model.dart';
import 'package:ani_stream/util/argument_objects.dart';
import 'package:ani_stream/util/mappers.dart';
import 'package:ani_stream/util/queries.dart';
import 'package:ani_stream/widgets/character_widget.dart';
import 'package:ani_stream/widgets/detail_screen_genre_text_widget.dart';
import 'package:ani_stream/widgets/episode_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class AnimeDetailScreen extends StatelessWidget {
  const AnimeDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as AnimeDetailsArguments;
    final anime = args.anime;
    late final TextTheme _textTheme = Theme.of(context).textTheme;
    late final ColorScheme _colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: _colorScheme.background,
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: 400,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(anime.coverImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            top: 60,
            left: 20,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.black38,
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_rounded),
              ),
            ),
          ),
          Positioned(
            top: 340,
            left: 0,
            right: 0,
            bottom: 0,
            child: SingleChildScrollView(
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16.0)),
                clipBehavior: Clip.hardEdge,
                // make sure we apply clip it properly
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    color: Colors.blueGrey.withOpacity(0.4),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 4.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          anime.engTitle,
                          style: _textTheme.headlineMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 5),
                        Query(
                          options: QueryOptions(
                            document: gql(
                              getAnimeDetailFromId(anime.id),
                            ),
                          ),
                          builder: (result, {fetchMore, refetch}) {
                            if (result.isLoading) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            if (result.hasException) {
                              print(result.exception.toString());
                              return Center(
                                child: Text(
                                  result.exception.toString(),
                                  style: _textTheme.headlineSmall,
                                ),
                              );
                            }
                            if (result.data != null) {
                              final AnimeDetail details =
                                  createAnimeDetailObject(result.data!);
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  DetailScreenGenreTextWidget(
                                      genresList: details.genres),
                                  Text("Status: ${details.status}"),
                                  Text(
                                    "Description: ",
                                    style: _textTheme.headlineMedium,
                                  ),
                                  Text(details.description, maxLines: 30),
                                  Text(
                                    "Characters: ",
                                    style: _textTheme.headlineMedium,
                                  ),
                                  SizedBox(
                                    height: 150,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: details.characters.length,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            width: 150,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: CharacterWidget(
                                              char: details.characters[index],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Episodes: ",
                                    style: _textTheme.headlineMedium,
                                  ),
                                  SizedBox(
                                    height: 150,
                                    child: details.episodesList.isEmpty
                                        ? Text(
                                            "No episode found 😓",
                                            style: _textTheme.headlineSmall,
                                          )
                                        : ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount:
                                                details.episodesList.length,
                                            itemBuilder: (context, index) {
                                              return Container(
                                                width: 150,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0),
                                                child: EpisodeWidget(
                                                  ep: details
                                                      .episodesList[index],
                                                ),
                                              );
                                            },
                                          ),
                                  ),
                                ],
                              );
                            }
                            return const Placeholder();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
