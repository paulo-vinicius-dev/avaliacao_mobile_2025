class Reviews { //meio complicado pra desenvolver agora talvez
  const Reviews({
    required this.id,
    required this.gameId,
    required this.rating,
    required this.comment,
  });

  final int id;
  final int gameId;
  final int rating;
  final String comment;
}