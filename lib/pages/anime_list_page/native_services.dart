import 'package:flutter/services.dart';
import 'anime_list_bloc.dart';

class NativeMethodChannel {
  static const _channel = MethodChannel('com.example/anime');
  static Future<void> callNativeFetchAnimeList() async {
    try {
      await _channel.invokeMethod('fetchAnimeList');
    } on PlatformException catch (e) {
      print("Failed to invoke method: '${e.message}'.");
    }
  }

  // Flutter listens to method calls from native
  static void listenForNativeCalls(AnimeListBloc animeListBloc) {
    _channel.setMethodCallHandler((MethodCall call) async {
      if (call.method == "fetchAnimeList") {
        int pageNumber = call.arguments['pageNumber'];
        String? type = call.arguments['type'];
        String? filter = call.arguments['filter'];
        animeListBloc.add(FetchAnimeList(pageNumber, type: type, filter: filter));
      }
      return;
    });
  }
}