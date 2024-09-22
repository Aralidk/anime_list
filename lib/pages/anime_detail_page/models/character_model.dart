class CharacterModel {
  String? images;
  String? name;
  CharacterModel({this.images, this.name});

  CharacterModel.fromJson(Map<String, dynamic> json) {
    images = json['images'] != null ? json['images']["jpg"]['image_url'] : null;
    name = json['name'];
  }
}
