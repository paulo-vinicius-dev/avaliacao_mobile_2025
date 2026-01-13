class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    this.profileImagePath,
    List<String>? favoriteGamesIds,
  }) : favoriteGamesIds = favoriteGamesIds ?? [];

  final String id;
  String name;
  String email;
  String? profileImagePath;
  List<String> favoriteGamesIds;

  bool isFavorite(String gameId) {
    return favoriteGamesIds.contains(gameId);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'profileImagePath': profileImagePath,
      'favoriteGamesIds': favoriteGamesIds,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      profileImagePath: map['profileImagePath'],
      favoriteGamesIds: List<String>.from(map['favoriteGamesIds'] ?? []),
    );
  }
}
