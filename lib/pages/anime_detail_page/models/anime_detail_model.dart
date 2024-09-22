class AnimeDetailModel {
  int? id;
  String? title;
  String? imageUrl;
  double? score;
  List? genres;
  int? episodes;
  String? synopsis;
  List? characters;

  AnimeDetailModel({
    this.id,
    this.title,
    this.imageUrl,
    this.score,
    this.synopsis,
    this.episodes,
    this.genres,
    this.characters,
  });

  factory AnimeDetailModel.fromJson(Map<String, dynamic> json) {
    return AnimeDetailModel(
      id: json['mal_id'] ?? 0,
      title: json['title'] ?? 'Unknown Title',
      imageUrl: (json['images'] != null && json['images']['jpg'] != null)
          ? json['images']['jpg']['image_url'] ?? ''
          : '',
      score: (json['score'] != null) ? (json['score'] as num).toDouble() : 0.0,
      synopsis: json['synopsis'] ?? '',
      episodes: json['episodes'] ?? 0,
      genres: (json['genres'] != null)
          ? (json['genres'] as List<dynamic>)
              .map((genre) => genre['name'] as String)
              .toList()
          : [],
      characters: const [],
    );
  }
}
