import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:avaliacao_mobile_2025/models/game.dart';
import 'package:avaliacao_mobile_2025/providers/games_provider.dart';

class FavoriteGamesNotifier extends Notifier<List<String>> {
  @override
  List<String> build() {
    return [];
  }

  void toggleFavorite(String gameId) {
    if (state.contains(gameId)) {
      // Removi
      state = state.where((id) => id != gameId).toList();
      ref
          .read(gamesProvider.notifier)
          .updateGameStatus(gameId, GameStatus.notStarted, isFavorite: false);
    } else {
      // Adiciona
      state = [...state, gameId];
      ref
          .read(gamesProvider.notifier)
          .updateGameStatus(gameId, GameStatus.wishPlay, isFavorite: true);
    }
  }

  bool isFavorite(String gameId) {
    return state.contains(gameId);
  }
}

final favoriteGamesProvider =
    NotifierProvider<FavoriteGamesNotifier, List<String>>(
      FavoriteGamesNotifier.new,
    );
