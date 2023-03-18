import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:ani_stream/models/anime_model.dart';
import 'package:ani_stream/util/argument_objects.dart';
import 'package:ani_stream/util/queries.dart';
import 'package:ani_stream/widgets/anime_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

final Map<String, dynamic> variables = {'id': 0};

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    late final TextTheme _textTheme = Theme.of(context).textTheme;
    late final ColorScheme _colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        color: _colorScheme.background,
        child: Center(
          child: Query(
            options: QueryOptions(document: gql(getTop10TrendingAnime)),
            builder: (result, {fetchMore, refetch}) {
              if (result.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (result.hasException) {
                print(result.exception.toString());
                return Text(result.exception.toString());
              }
              if (result.data != null) {
                final animeList = result.data!['Page'];
                final List<Anime> l1 = map(animeList);
                return Center(
                  child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 2 / 3,
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                    children: List.generate(
                      l1.length,
                      (index) => AnimeCard(
                        anime: l1[index],
                        callback: () => Navigator.pushNamed(
                          context,
                          '/animeDetails',
                          arguments: AnimeDetailsArguments(l1[index]),
                        ),
                      ),
                    ),
                  ),
                );
              }
              return const Placeholder();
            },
          ),
        ),
      ),
    );
  }

  List<Anime> map(dynamic list) {
    final List l1 = list['media'];
    return l1
        .map((e) => Anime(e['id'], e['title']['english'], e['averageScore'],
            e['coverImage']['large']))
        .toList();
  }
}
