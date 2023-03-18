const String getTop10TrendingAnime = r'''
query GetHighestRatedAnime {
  Page(perPage: 10) {
    media(type: ANIME, sort: SCORE_DESC) {
      id
      title {
        romaji
        english
        native
      }
      averageScore
      coverImage {
        large
      }
    }
  }
}
''';

String getAnimeDetailFromId(int id) {
  return '''
query {
  Media (id:$id) {
    id
    title {
      english
    }
    description
    genres
    status
    episodes
    streamingEpisodes {
      title
      thumbnail
    }
    characters {
      edges {
        node {
          id
          name {
            full
          }
          image {
            medium
          }
        }
        role
      }
    }
  }
}''';
}
