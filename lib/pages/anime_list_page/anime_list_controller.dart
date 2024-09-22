import 'package:anime_list/core/network/network_manager.dart';
import 'package:anime_list/pages/anime_list_page/models/anime_list_model.dart';
import '../../core/constants/app_const.dart';

class AnimeController {
  static Future<List<AnimeListModel>> getAnimeList(int pageNumber,
      {String? type, String? filter}) async {
    try {
      final response =
          await NetworkManager().get("$baseUrl/top/anime", queryParams: {
        "limit": 20,
        "page": pageNumber,
        "filter": filter,
        "type": type,
      });
      if (response.statusCode == 200) {
        List data = response.data;
        List<AnimeListModel> resData = [];
        for (var element in data) {
          resData.add(AnimeListModel.fromJson(element));
        }
        return resData;
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception: $e");
    }
    return [];
  }
}
