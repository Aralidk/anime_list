enum AnimeFilterEnum{
  movie(1,"Movie"),
  tv(2,"Tv"),
  upcoming(3,"Upcoming");

  final int filterValue;
  final String description;
  const AnimeFilterEnum(this.filterValue, this.description);
}