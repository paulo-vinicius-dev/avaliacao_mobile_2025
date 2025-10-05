enum GameStatus {
  jogando,
  concluido,
  desejoIniciar,
  aposentado,
}

class Game {
  const Game({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.genres,
    required this.releaseDate,
    this.status = GameStatus.desejoIniciar,
    this.hoursPlayed = 0,
    this.platforms = const [],
    this.synopsis = '',
  });

  final String id;
  final String title;
  final String imageUrl;
  final List<int> genres;
  final DateTime releaseDate;
  final GameStatus status;
  final num hoursPlayed;
  final List<String> platforms;
  final String synopsis;
}