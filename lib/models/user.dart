class User {
  User({required this.id, required this.name, List<String>? favoriteGamesIds})
    : favoriteGamesIds = favoriteGamesIds ?? [];

  final String id;
  final String name;
  final List<String> favoriteGamesIds;

  bool isFavorite(String gameId) {
    return favoriteGamesIds.contains(gameId);
  }
}
