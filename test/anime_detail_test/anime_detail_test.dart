import 'package:anime_list/pages/anime_detail_page/bloc/anime_detail_bloc.dart';
import 'package:anime_list/pages/anime_detail_page/anime_detail_view.dart';
import 'package:anime_list/pages/anime_detail_page/bloc/detail_states.dart';
import 'package:anime_list/pages/anime_detail_page/models/anime_detail_model.dart';
import 'package:anime_list/pages/anime_detail_page/models/character_model.dart';
import 'package:anime_list/pages/anime_detail_page/widgets/character_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAnimeDetailBloc extends Mock implements AnimeDetailBloc {}

void main() {
  late MockAnimeDetailBloc mockBloc;

  setUp(() {
    mockBloc = MockAnimeDetailBloc();
  });

  Widget createWidgetUnderTest() {
    return BlocProvider.value(
      value: mockBloc,
      child: const MaterialApp(
        home: AnimeDetailView(
          animeId: 1,
          animeName: 'Test Anime',
        ),
      ),
    );
  }

  testWidgets('CharacterCard displays character image and name',
      (WidgetTester tester) async {
    final character = CharacterModel(
      name: 'Test Character',
      images: 'https://example.com/test_character.png',
    );
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CharacterCard(character: character),
        ),
      ),
    );
    expect(find.text('Test Character'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
    final image = tester.widget<Image>(find.byType(Image));
    expect(image.image, isA<NetworkImage>());
    expect((image.image as NetworkImage).url,
        'https://example.com/test_character.png');
  });

  testWidgets('CharacterCard shows placeholder image on error',
      (WidgetTester tester) async {
    final character = CharacterModel(
      name: 'Test Character',
      images: null,
    );
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CharacterCard(character: character),
        ),
      ),
    );

    expect(find.byType(Image), findsOneWidget);
    final image = tester.widget<Image>(find.byType(Image));
    expect(image.image, isA<AssetImage>());
    expect((image.image as AssetImage).assetName, 'assets/placeholder.png');
  });

  testWidgets('Wrap displays Chip for each genre', (WidgetTester tester) async {
    final animeDetail = AnimeDetailModel(
      title: 'Sample Anime',
      genres: ['Action', 'Adventure', 'Fantasy'], // Sample genres
    );
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Wrap(
            children: List.generate(
              animeDetail.genres?.length ?? 0,
                  (index) => Chip(label: Text(animeDetail.genres![index])),
            ),
          ),
        ),
      ),
    );
    expect(find.byType(Chip), findsNWidgets(animeDetail.genres!.length));
    for (var genre in animeDetail.genres!) {
      expect(find.text(genre), findsOneWidget);
    }
  });


  testWidgets('ListView displays CharacterCard for each character', (WidgetTester tester) async {
    final characters = [
      CharacterModel(name: 'Character 1', images: 'https://example.com/char1.png'),
      CharacterModel(name: 'Character 2', images: 'https://example.com/char2.png'),
      CharacterModel(name: 'Character 3', images: 'https://example.com/char3.png'),
    ];
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: characters.length,
              itemBuilder: (context, index) {
                return CharacterCard(character: characters[index]);
              },
            ),
          ),
        ),
      ),
    );
    expect(find.byType(CharacterCard), findsNWidgets(characters.length));
    for (var character in characters) {
      expect(find.text(character.name!), findsOneWidget);
    }
  });


  testWidgets('renders error state', (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(AnimeDetailError('Error Occurred'));
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle(); // Allow UI to update
    expect(find.text('Error Occured'), findsOneWidget);
  });
}
