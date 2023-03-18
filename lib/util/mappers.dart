import 'package:ani_stream/models/anime_model.dart';
import 'package:ani_stream/models/character.dart';
import 'package:ani_stream/models/episode_model.dart';

AnimeDetail createAnimeDetailObject(Map<String, dynamic> response) {
  print(response['Media']['genres'].toString());
  return AnimeDetail(
    response['Media']['id'].toString(),
    response['Media']['title']['english'],
    response['Media']['description'],
    mapToGenresList(response['Media']['genres']),
    response['Media']['status'],
    response['Media']['episodes'].toString(),
    mapToCharacterList(
      response['Media']['characters'],
    ),
    mapToEpisodeList(response['Media']['streamingEpisodes']),
  );
}

List<EpisodeModel> mapToEpisodeList(List<Object?> response) {
  List<EpisodeModel> epList = <EpisodeModel>[];
  for (var episode in response) {
    episode as Map<String, dynamic>;
    epList.add(
      EpisodeModel(
        episode['title'],
        episode['thumbnail'],
      ),
    );
  }
  return epList;
}

List<Character> mapToCharacterList(Map<String, dynamic> response) {
  List<Character> charList = <Character>[];
  for (var character in response['edges']) {
    charList.add(Character(
        character['node']['id'],
        character['node']['name']['full'],
        character['role'],
        character['node']['image']['medium']));
  }
  return charList;
}

List<String> mapToGenresList(List<Object?> response) {
  List<String> genres = <String>[];
  for (var genre in response) {
    genres.add(genre.toString());
  }
  return genres;
}
