import 'package:anime_list/common/loading_shimmer.dart';
import 'package:anime_list/pages/anime_list_page/anime_list_bloc.dart';
import 'package:anime_list/pages/anime_list_page/models/anime_list_model.dart';
import 'package:anime_list/pages/anime_list_page/widgets/anime_listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAnimeListBloc extends Mock implements AnimeListBloc {}

void main() {
  group('AnimeListDataBody', () {
    testWidgets('Displays loading when state is AnimeListLoading', (WidgetTester tester) async {
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
              imageUrl: "https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png",
              score: 8.5,
            ),
            AnimeListModel(
              id: 2,
              title: "Another Anime",
              imageUrl: "https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png",
              score: 7.5,
            ),
          ];

          when(() => mockBloc.state)
              .thenReturn(AnimeListLoaded( animeList,null,null));


          await tester.pumpWidget(
            BlocProvider<AnimeListBloc>(
              create: (context) => mockBloc,
              child: MaterialApp(
                home: Scaffold(
                  body: AnimeListDataBody(state: AnimeListLoaded( animeList,  null,null)),
                ),
              ),
            ),
          );

          expect(find.text("Test Anime"), findsOneWidget);
          expect(find.text("Another Anime"), findsOneWidget);

          await tester.tap(find.text("Test Anime"));
          await tester.pumpAndSettle();
        });

    testWidgets('Displays error message when state is AnimeListError', (WidgetTester tester) async {
      final mockBloc = MockAnimeListBloc();
      when(() => mockBloc.state).thenReturn(AnimeListError( "Error!"));

      await tester.pumpWidget(
        BlocProvider<AnimeListBloc>(
          create: (context) => mockBloc,
          child: MaterialApp(
            home: Scaffold(
              body: AnimeListDataBody(state: AnimeListError( "Error!")),
            ),
          ),
        ),
      );

      expect(find.text("Error Occurred"), findsOneWidget);
    });
  });
}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}