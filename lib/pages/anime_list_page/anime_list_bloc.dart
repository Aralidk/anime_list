import 'package:flutter_bloc/flutter_bloc.dart';
import 'anime_list_controller.dart';
import 'models/anime_list_model.dart';

abstract class AnimeListEvent {}

class FetchAnimeList extends AnimeListEvent {
  final int pageNumber;
  final String? type;
  final String? filter;

  FetchAnimeList(this.pageNumber, {this.type, this.filter});
}

abstract class AnimeListState {}

class AnimeListReachedBottom extends AnimeListEvent {}

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

class ChangeAnimeFilter extends AnimeListEvent {
  final bool? upcoming;
  final String? type;
  ChangeAnimeFilter({this.upcoming, this.type});
}

class AnimeListBloc extends Bloc<AnimeListEvent, AnimeListState> {
  bool isUpcomingFilter = false;
  String? currentType;
  int currentPage = 1;
  bool isLastPage = false;
  bool isFetching = false;
  List<AnimeListModel> allAnimeList = [];

  AnimeListBloc() : super(AnimeListInitial()) {
    on<FetchAnimeList>(_onFetchAnimeList);
    on<ChangeAnimeFilter>(_onChangeAnimeFilter);
    on<AnimeListReachedBottom>(_onAnimeListReachedBottom);
  }

  Future<void> _onFetchAnimeList(
      FetchAnimeList event, Emitter<AnimeListState> emit) async {
    if (isLastPage || isFetching) return;
    isFetching = true;
    if(allAnimeList.isEmpty){
      emit(AnimeListLoading());
    }
    try {
      bool isUpcoming = (event.filter == "Upcoming");
      AnimeController controller = AnimeController();
      List<AnimeListModel> newAnimeList = await controller.getAnimeList(
        event.pageNumber,
        type: event.type ?? currentType,
        filter: isUpcoming ? "Upcoming" : null,
      );

      if (newAnimeList.isEmpty) {
        isLastPage = true;
      }
      allAnimeList.addAll(newAnimeList);
      currentPage = event.pageNumber;
      currentType = event.type ?? currentType;
      isFetching = false;
      emit(AnimeListLoaded(allAnimeList, isUpcoming, currentType));
    } catch (e) {
      isFetching = false;
      emit(AnimeListError("Failed to fetch anime list: $e"));
    }
  }

  void _onChangeAnimeFilter(
      ChangeAnimeFilter event, Emitter<AnimeListState> emit) {
    if (state is AnimeListLoaded) {
      bool isUpcoming = event.upcoming ?? false;
      currentPage = 1;
      isLastPage = false;
      allAnimeList.clear();
      add(FetchAnimeList(1,
          filter: isUpcoming ? "Upcoming" : null,
          type: event.type ?? currentType));
    }
  }

  void _onAnimeListReachedBottom(
      AnimeListReachedBottom event, Emitter<AnimeListState> emit) {
    if (state is AnimeListLoaded) {
      add(FetchAnimeList(currentPage + 1,
          filter: isUpcomingFilter ? "Upcoming" : null, type: currentType));
    }
  }
}
