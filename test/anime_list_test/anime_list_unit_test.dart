import 'package:flutter_test/flutter_test.dart';
import 'package:anime_list/pages/anime_list_page/anime_list_bloc.dart';
import 'package:anime_list/pages/anime_list_page/models/anime_list_model.dart';
import 'package:anime_list/pages/anime_list_page/anime_list_controller.dart';
import 'package:mocktail/mocktail.dart';

class MockAnimeController extends Mock implements AnimeController {}

void main() {
  late AnimeListBloc animeListBloc;
  late MockAnimeController mockAnimeController;

  setUp(() {
    mockAnimeController = MockAnimeController();
    animeListBloc = AnimeListBloc();

    when(() =>
        mockAnimeController.getAnimeList(any(),
            type: any(named: 'type'),
            filter: any(named: 'filter'))).thenAnswer((_) async => [
          AnimeListModel(title: "Anime 1", imageUrl: null, id: 1, score: 8.0),
          AnimeListModel(title: "Anime 2", imageUrl: null, id: 2, score: 9.0),
        ]);
  });

  tearDown(() {
    animeListBloc.close(); // Close the bloc after each test
  });

  test('initial state is AnimeListInitial', () {
    expect(animeListBloc.state, isA<AnimeListInitial>());
  });

  test('fetches anime list and emits loading and loaded states', () async {
    animeListBloc.add(FetchAnimeList(1));

    await expectLater(
      animeListBloc.stream,
      emitsInOrder([
        isA<AnimeListLoading>(),
        isA<AnimeListLoaded>(),
      ]),
    );
    expect(animeListBloc.state, isA<AnimeListLoaded>());
    final loadedState = animeListBloc.state as AnimeListLoaded;
    expect(loadedState.animeList.length, 20);
  });

  test('reaches bottom and fetches next page', () async {
    animeListBloc.add(FetchAnimeList(1));
    await animeListBloc.stream.firstWhere((state) => state is AnimeListLoaded);
    animeListBloc.add(AnimeListReachedBottom());
    final loadedState = animeListBloc.state as AnimeListLoaded;
    expect(loadedState.animeList.length, 20);
  });
}
