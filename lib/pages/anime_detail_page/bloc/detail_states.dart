import '../models/anime_detail_model.dart';
import '../models/character_model.dart';

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