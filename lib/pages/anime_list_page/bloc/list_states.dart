import '../models/anime_list_model.dart';

abstract class AnimeListState {}

class AnimeListInitial extends AnimeListState {}

class AnimeListLoading extends AnimeListState {}

class AnimeListLoaded extends AnimeListState {
  final List<AnimeListModel> animeList;
  final bool? selectedFilter;
  final String? type;

  AnimeListLoaded(this.animeList, this.selectedFilter, this.type);
}

class AnimeListError extends AnimeListState {
  final String message;
  AnimeListError(this.message);
}
