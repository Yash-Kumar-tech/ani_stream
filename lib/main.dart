import 'dart:io';

import 'package:ani_stream/screens/anime_detail_screen.dart';
import 'package:ani_stream/screens/main_screen.dart';
import 'package:ani_stream/util/clients.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

final HttpLink httpLink = HttpLink('https://graphql.anilist.co');

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(GraphQLProvider(client: animeListClient, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/animeDetails': (context) => const AnimeDetailScreen(),
      },
      title: 'Flutter Demo',
      theme: ThemeData.dark(useMaterial3: true),
      debugShowCheckedModeBanner: false,
    );
  }
}
