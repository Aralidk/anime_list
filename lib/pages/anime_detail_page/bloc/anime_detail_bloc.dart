import 'package:anime_list/pages/anime_detail_page/models/character_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../anime_detail_controller.dart';
import 'detail_events.dart';
import 'detail_states.dart';
import '../models/anime_detail_model.dart';

class AnimeDetailBloc extends Bloc<AnimeDetailEvent, AnimeDetailState> {
  AnimeDetailBloc() : super(AnimeDetailInitial()) {
    on<FetchAnimeDetail>(_mapFetchAnimeDetailToState);
  }

  Future<void> _mapFetchAnimeDetailToState(
      FetchAnimeDetail event, Emitter<AnimeDetailState> emit) async {
    emit(AnimeDetailLoading());
    try {
      AnimeDetailController detailController = AnimeDetailController();
      AnimeDetailModel? detailResponse =
          await detailController.getAnimeDetail(event.animeId);
      final charactersResponse =
          await detailController.getAnimeCharacters(event.animeId);

      if (detailResponse != null && charactersResponse != null) {
        AnimeDetailModel animeDetail = detailResponse;
        List<CharacterModel> characters = charactersResponse;

        emit(AnimeDetailLoaded(animeDetail, characters));
      } else {
        emit(AnimeDetailError("Failed to fetch anime details or characters"));
      }
    } catch (e) {
      emit(AnimeDetailError("Error: $e"));
    }
  }
}
