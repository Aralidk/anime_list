import 'package:anime_list/common/loading_shimmer.dart';
import 'package:anime_list/pages/anime_list_page/anime_list_bloc.dart';
import 'package:anime_list/pages/anime_list_page/anime_list_controller.dart';
import 'package:anime_list/pages/anime_list_page/anime_list_enums.dart';
import 'package:anime_list/pages/anime_list_page/anime_list_view.dart';
import 'package:anime_list/pages/anime_list_page/models/anime_list_model.dart';
import 'package:anime_list/pages/anime_list_page/widgets/anime_list_databody.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAnimeListBloc extends Mock implements AnimeListBloc {}

class MockAnimeController extends Mock implements AnimeController {}

void main() {
  group('AnimeList', () {
    late MockAnimeListBloc mockBloc;
    late MockAnimeController mockAnimeController;


    setUp(() {
      mockBloc = MockAnimeListBloc();
      mockAnimeController = MockAnimeController();
      when(() =>
          mockAnimeController.getAnimeList(any(),
              type: any(named: 'type'),
              filter: any(named: 'filter'))).thenAnswer((_) async =>
          [AnimeListModel(title: "title", imageUrl: null, id: 1, score: 1)]);
      when(() => mockBloc.state).thenReturn(AnimeListLoading());
    });

    testWidgets('displays loading state correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        BlocProvider<AnimeListBloc>(
          create: (_) => mockBloc,
          child: const MaterialApp(
            home: Scaffold(
              body: AnimeListView(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(AnimeListDataBody), findsOneWidget);
      expect(find.byType(CheckboxListTile), findsOneWidget);
      expect(find.text(AnimeFilterEnum.upcoming.description), findsOneWidget);
    });

    testWidgets('displays anime list correctly when loaded',
        (WidgetTester tester) async {
      final animeListState = AnimeListLoaded(
        [],
        true,
        null,
      );

      when(() => mockBloc.state).thenReturn(animeListState);
      await tester.pumpWidget(
        BlocProvider<AnimeListBloc>(
          create: (_) => mockBloc,
          child: const MaterialApp(
            home: Scaffold(
              body: AnimeListView(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(CheckboxListTile), findsOneWidget);
      expect(
          tester.widget<CheckboxListTile>(find.byType(CheckboxListTile)).value,
          isFalse);
      expect(find.byType(AnimeListDataBody), findsOneWidget);
    });

    testWidgets('Displays loading when state is AnimeListLoading',
        (WidgetTester tester) async {
      final mockBloc = MockAnimeListBloc();
      when(() => mockBloc.state).thenReturn(AnimeListLoading());

      await tester.pumpWidget(
        BlocProvider<AnimeListBloc>(
          create: (context) => mockBloc,
          child: MaterialApp(
            home: Scaffold(
              body: AnimeListDataBody(state: AnimeListLoading()),
            ),
          ),
        ),
      );
      expect(find.byType(KrakenLoadingShimmer), findsOneWidget);
    });

    testWidgets(
        'Displays anime list and navigates to detail on tap when state is AnimeListLoaded',
        (WidgetTester tester) async {
      final mockBloc = MockAnimeListBloc();

      final animeList = [
        AnimeListModel(
          id: 1,
          title: "Test Anime",
          imageUrl: null,
          score: 8.5,
        ),
        AnimeListModel(
          id: 2,
          title: "Another Anime",
          imageUrl: null,
          score: 7.5,
        ),
      ];
      when(() => mockBloc.state)
          .thenReturn(AnimeListLoaded(animeList, null, null));

      await tester.runAsync(() async {
        await tester.pumpWidget(
          BlocProvider<AnimeListBloc>(
            create: (context) => mockBloc,
            child: MaterialApp(
              home: Scaffold(
                body: AnimeListDataBody(
                    state: AnimeListLoaded(animeList, null, null)),
              ),
            ),
          ),
        );
      });
      expect(find.text("Test Anime"), findsOneWidget);
      expect(find.text("Another Anime"), findsOneWidget);
      await tester.tap(find.text("Test Anime"));
      await tester.pumpAndSettle();
    });

    testWidgets('Displays error message when state is AnimeListError',
        (WidgetTester tester) async {
      final mockBloc = MockAnimeListBloc();
      when(() => mockBloc.state).thenReturn(AnimeListError("Error!"));

      await tester.pumpWidget(
        BlocProvider<AnimeListBloc>(
          create: (context) => mockBloc,
          child: MaterialApp(
            home: Scaffold(
              body: AnimeListDataBody(state: AnimeListError("Error!")),
            ),
          ),
        ),
      );
      expect(find.text("Error Occurred"), findsOneWidget);
    });
  });
}




