enum gameStatus {
  Jogando,
  Concluido,
  DesejoIniciar,
  Aposentado,
}

class Game {
  const Game({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.genres,
    required this.releaseDate,
    this.status = gameStatus.DesejoIniciar,
    this.hoursPlayed = 0,
  });

  final String id;
  final String title;
  final String imageUrl;
  final List<int> genres;
  final DateTime releaseDate;
  final gameStatus status;
  final num hoursPlayed;
}