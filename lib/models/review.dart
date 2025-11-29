class Reviews {
  Reviews({
    required this.id,
    required this.gameId,
    required this.rating,
    required this.comment,
  });

  final int id;
  final int gameId;
  int rating;
  String comment;
}
