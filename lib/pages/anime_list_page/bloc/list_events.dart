abstract class AnimeListEvent {}

class FetchAnimeList extends AnimeListEvent {
  final int pageNumber;
  final String? type;
  final String? filter;

  FetchAnimeList(this.pageNumber, {this.type, this.filter});
}

class AnimeListReachedBottom extends AnimeListEvent {}

class ChangeAnimeFilter extends AnimeListEvent {
  final bool? upcoming;
  final String? type;
  ChangeAnimeFilter({this.upcoming, this.type});
}
