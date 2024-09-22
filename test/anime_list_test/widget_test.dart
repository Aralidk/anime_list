import 'package:anime_list/common/loading_shimmer.dart';
import 'package:anime_list/pages/anime_list_page/models/anime_list_model.dart';
import 'package:anime_list/pages/anime_list_page/widgets/anime_listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:anime_list/pages/anime_list_page/anime_list_bloc.dart';

void main() {
  testWidgets('AnimeListDataBody displays loading, then anime list', (WidgetTester tester) async {
    // AnimeListBloc'u başlatın
    final animeListBloc = AnimeListBloc();

    await tester.pumpWidget(
      BlocProvider<AnimeListBloc>(
        create: (context) => animeListBloc,
        child: MaterialApp(
          home: Scaffold(
            body: AnimeListDataBody(state: AnimeListLoading()), // İlk başta loading durumu
          ),
        ),
      ),
    );

    // Başlangıçta yükleniyor durumunun görünmesini bekleyin
    expect(find.byType(KrakenLoadingShimmer), findsOneWidget);

    // Yüklenme durumunu simüle edin
    animeListBloc.emit(AnimeListLoaded(
       [
        AnimeListModel(id: 1, title: "Test Anime", imageUrl: "http://example.com/image.jpg", score: 8.5),
        AnimeListModel(id: 2, title: "Another Anime", imageUrl: "http://example.com/image2.jpg", score: 7.5),
      ],
       false,
      null
    ));
    await tester.pump(); // Give time for the UI to rebuild
    await tester.pumpAndSettle(Duration(seconds: 5)); // Wait for the widget tree to stabilize

    expect(find.text("Test Anime"), findsOneWidget);
    expect(find.text("Another Anime"), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);

    await tester.tap(find.text("Test Anime"));
    await tester.pumpAndSettle();
    expect(find.text("Test Anime"), findsOneWidget);
  });
}
