class AnimeListModel {
  int? id;
  String? title;
  String? imageUrl;
  double? score;

  AnimeListModel({
    this.id,
    this.title,
    this.imageUrl,
    this.score,
  });

  factory AnimeListModel.fromJson(Map<String, dynamic> json) {
    return AnimeListModel(
      id: json['mal_id'] ?? 0,
      score: (json['score'] != null) ? (json['score'] as num).toDouble() : 0.0,
      title: json['title'] ?? 'Unknown Title',
      imageUrl: (json['images'] != null && json['images']['jpg'] != null)
          ? json['images']['jpg']['image_url'] ?? ''
          : '',
    );
  }
}
