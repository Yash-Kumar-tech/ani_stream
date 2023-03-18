import 'package:ani_stream/main.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

final ValueNotifier<GraphQLClient> animeListClient = ValueNotifier(
  GraphQLClient(
    link: httpLink,
    cache: GraphQLCache(),
  ),
);
