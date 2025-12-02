import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:avaliacao_mobile_2025/models/game.dart';
import 'package:avaliacao_mobile_2025/providers/games_provider.dart';
import 'package:avaliacao_mobile_2025/providers/local_storage.dart';

class FavoriteGamesNotifier extends Notifier<List<String>> {
  final List<String> _initialFavorites;
  LocalStorage _storage = LocalStorage();

  FavoriteGamesNotifier(this._initialFavorites);

  @override
  List<String> build() {
    return _initialFavorites;
  }

  void setUsername(String? username) {
    _storage = LocalStorage(username: username);
  }

  Future<void> loadUserFavorites(String? username) async {
    _storage = LocalStorage(username: username);
    final favorites = await _storage.readFavorites();
    state = favorites;
  }

  void toggleFavorite(String gameId) {

    if (state.contains(gameId)) {
      state = state.where((id) => id != gameId).toList();
      ref
          .read(gamesProvider.notifier)
          .updateGameStatus(gameId, GameStatus.notStarted, isFavorite: false);
    } else {
      state = [...state, gameId];
      ref
          .read(gamesProvider.notifier)
          .updateGameStatus(gameId, GameStatus.wishPlay, isFavorite: true);
    }

    _storage.saveFavorites(state);
  }

  bool isFavorite(String gameId) {
    return state.contains(gameId);
  }
  
  void clearFavorites() {
    state = [];
  }
}

final favoriteGamesProvider =
  NotifierProvider<FavoriteGamesNotifier, List<String>>(() {
    return FavoriteGamesNotifier([]);
});