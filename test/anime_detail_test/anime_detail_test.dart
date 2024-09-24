import 'package:anime_list/common/loading_shimmer.dart';
import 'package:anime_list/pages/anime_detail_page/anime_detail_bloc.dart';
import 'package:anime_list/pages/anime_detail_page/anime_detail_view.dart';
import 'package:anime_list/pages/anime_detail_page/models/anime_detail_model.dart';
import 'package:anime_list/pages/anime_detail_page/widgets/character_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';


class MockAnimeDetailBloc extends Mock implements AnimeDetailBloc {}

void main() {
  late AnimeDetailBloc animeDetailBloc;

  setUp(() {
    animeDetailBloc = MockAnimeDetailBloc();
  });

  Widget createWidgetUnderTest() {
    return BlocProvider<AnimeDetailBloc>.value(
      value: animeDetailBloc,
      child: const MaterialApp(
        home: AnimeDetailView(animeId: 1, animeName: "Test Anime"),
      ),
    );
  }

  testWidgets('shows shimmer when state is AnimeDetailLoading',
          (WidgetTester tester) async {
        when(() => animeDetailBloc.state).thenReturn(AnimeDetailLoading());

        // Build the widget
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle(); // Allow any animations or transitions to complete

        // Assert that the loading shimmer is displayed
        expect(find.byType(KrakenLoadingShimmer), findsOneWidget);
      });

  testWidgets('shows anime detail when state is AnimeDetailLoaded',
          (WidgetTester tester) async {
        final animeDetail = AnimeDetailModel(
          title: "Test Anime",
          imageUrl: "https://example.com/image.jpg",
          genres: ["Action", "Adventure"],
          score: 9.0,
          episodes: 12,
          synopsis: "Test synopsis",
        );

        when(() => animeDetailBloc.state)
            .thenReturn(AnimeDetailLoaded(animeDetail, []));

        // Build the widget
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle(); // Allow any animations or transitions to complete

        // Assert that the correct anime details are displayed
        expect(find.text("Test Anime"), findsOneWidget);
        expect(find.text("Rating: 9.0"), findsOneWidget);
        expect(find.text("Episodes: 12"), findsOneWidget);
        expect(find.text("Synopsis:"), findsOneWidget);
        expect(find.text("Test synopsis"), findsOneWidget);
        expect(find.byType(CharacterCard), findsNothing); // Assuming no characters in this test
        expect(find.byType(Image), findsOneWidget); // Check for the image widget
      });

  testWidgets('shows error message when state is AnimeDetailError',
          (WidgetTester tester) async {
        when(() => animeDetailBloc.state)
            .thenReturn(AnimeDetailError("Failed to fetch details"));
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();
        expect(find.text("Error Occured"), findsOneWidget);
      });
}
