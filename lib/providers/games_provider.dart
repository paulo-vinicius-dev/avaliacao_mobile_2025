import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:avaliacao_mobile_2025/models/game.dart';
import 'package:avaliacao_mobile_2025/data/dummy_data.dart';
import 'package:avaliacao_mobile_2025/providers/local_storage.dart';

class GamesNotifier extends Notifier<List<Game>> {
  final Map<String, GameStatus> _initialStatuses;
  final List<String> _initialFavorites;
  LocalStorage _storage = LocalStorage();

  GamesNotifier(this._initialStatuses, this._initialFavorites);

  @override
  List<Game> build() {
    return [
      for (final game in myGames)
        Game(
          id: game.id,
          title: game.title,
          imageUrl: game.imageUrl,
          genres: game.genres,
          releaseDate: game.releaseDate,
          status: _initialStatuses[game.id] ?? game.status,
          isFavorite: _initialFavorites.contains(game.id),
          hoursPlayed: game.hoursPlayed,
          platforms: game.platforms,
          synopsis: game.synopsis,
        )
    ];
  }

  void setUsername(String? username) {
    _storage = LocalStorage(username: username);
  }

  Future<void> loadUserGames(String? username) async {
    _storage = LocalStorage(username: username);
    final statuses = await _storage.readStatuses();
    final favorites = await _storage.readFavorites();
    
    state = [
      for (final game in myGames)
        Game(
          id: game.id,
          title: game.title,
          imageUrl: game.imageUrl,
          genres: game.genres,
          releaseDate: game.releaseDate,
          status: statuses[game.id] ?? GameStatus.notStarted,
          isFavorite: favorites.contains(game.id),
          hoursPlayed: game.hoursPlayed,
          platforms: game.platforms,
          synopsis: game.synopsis,
        )
    ];
  }

  void updateGameStatus(
      String gameId,
      GameStatus newStatus, {
        bool isFavorite = true,
      }) {
    state = [
      for (final game in state)
        if (game.id == gameId)
          Game(
            id: game.id,
            title: game.title,
            imageUrl: game.imageUrl,
            genres: game.genres,
            releaseDate: game.releaseDate,
            isFavorite: isFavorite,
            status: newStatus,
            hoursPlayed: game.hoursPlayed,
            platforms: game.platforms,
            synopsis: game.synopsis,
          )
        else
          game,
    ];
    _saveStatusesToDisk();
  }
  
  void _saveStatusesToDisk() {
    final Map<String, GameStatus> statusMap = {};
    for (final game in state) {
      if (game.status != GameStatus.notStarted) {
        statusMap[game.id] = game.status;
      }
    }
    _storage.saveStatuses(statusMap);
  }
}

final gamesProvider = NotifierProvider<GamesNotifier, List<Game>>(() {
  return GamesNotifier({}, []);
});