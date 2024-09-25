import 'package:anime_list/pages/anime_detail_page/models/character_model.dart';
import '../../core/constants/app_const.dart';
import '../../core/network/network_manager.dart';
import 'models/anime_detail_model.dart';

class AnimeDetailController {
   Future<AnimeDetailModel?> getAnimeDetail(int animeId) async {
    var response = await NetworkManager().get("$baseUrl/anime/$animeId");
    if (response.statusCode == 200) {
      return AnimeDetailModel.fromJson(response.data);
    }
    return null;
  }

   Future<List<CharacterModel>?> getAnimeCharacters(int animeId) async {
    var response =
        await NetworkManager().get("$baseUrl/anime/$animeId/characters");

    if (response.statusCode == 200) {
      List data = response.data;
      List<CharacterModel> resData = [];
      for (var element in data) {
        resData.add(CharacterModel.fromJson(element["character"]));
      }
      return resData;
    }
    return null;
  }
}
