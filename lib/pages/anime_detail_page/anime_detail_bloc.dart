import 'package:anime_list/pages/anime_detail_page/models/character_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'anime_detail_controller.dart';
import 'models/anime_detail_model.dart';

// Events
abstract class AnimeDetailEvent {}

class FetchAnimeDetail extends AnimeDetailEvent {
  final int animeId;
  FetchAnimeDetail(this.animeId);
}

// States
abstract class AnimeDetailState {}

class AnimeDetailInitial extends AnimeDetailState {}

class AnimeDetailLoading extends AnimeDetailState {}

class AnimeDetailLoaded extends AnimeDetailState {
  final AnimeDetailModel animeDetail;
  final List<CharacterModel> characters;

  AnimeDetailLoaded(this.animeDetail, this.characters);
}

class AnimeDetailError extends AnimeDetailState {
  final String message;
  AnimeDetailError(this.message);
}

// Bloc
class AnimeDetailBloc extends Bloc<AnimeDetailEvent, AnimeDetailState> {
  AnimeDetailBloc() : super(AnimeDetailInitial()) {
    on<FetchAnimeDetail>(_mapFetchAnimeDetailToState);
  }

  Future<void> _mapFetchAnimeDetailToState(
      FetchAnimeDetail event, Emitter<AnimeDetailState> emit) async {
    emit(AnimeDetailLoading());
    try {
      AnimeDetailModel? detailResponse =
          await AnimeDetailController.getAnimeDetail(event.animeId);
      final charactersResponse =
          await AnimeDetailController.getAnimeCharacters(event.animeId);

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
