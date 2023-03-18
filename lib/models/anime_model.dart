import 'package:ani_stream/models/character.dart';
import 'package:ani_stream/models/episode_model.dart';

class Anime {
  final int id;
  final String engTitle;
  final int averageScore;
  final String coverImage;

  Anime(this.id, this.engTitle, this.averageScore, this.coverImage);
}

class AnimeDetail {
  final String id;
  final String engTitle;
  final String description;
  final List<String> genres;
  final String status;
  final String episodes;
  final List<EpisodeModel> episodesList;
  final List<Character> characters;

  AnimeDetail(this.id, this.engTitle, this.description, this.genres,
      this.status, this.episodes, this.characters, this.episodesList);
}
