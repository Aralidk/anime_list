abstract class AnimeDetailEvent {}

class FetchAnimeDetail extends AnimeDetailEvent {
  final int animeId;
  FetchAnimeDetail(this.animeId);
}
