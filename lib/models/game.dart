class Game {
  Game({
    required this.id,
    required this.genreId,
    required this.title,
    required this.imageUrl,
    required this.releaseDate,
  });

  final int id;
  final int genreId;
  final String title;
  final String imageUrl;
  final DateTime releaseDate;
}