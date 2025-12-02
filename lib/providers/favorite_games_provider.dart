import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:avaliacao_mobile_2025/models/game.dart';
import 'package:avaliacao_mobile_2025/providers/games_provider.dart';
import 'package:avaliacao_mobile_2025/providers/local_storage.dart';

class FavoriteGamesNotifier extends Notifier<List<String>> {
  final List<String> _initialFavorites;
  final _storage = LocalStorage();

  FavoriteGamesNotifier(this._initialFavorites);

  @override
  List<String> build() {
    return _initialFavorites;
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
}

final favoriteGamesProvider =
  NotifierProvider<FavoriteGamesNotifier, List<String>>(() {
    return FavoriteGamesNotifier([]);
});