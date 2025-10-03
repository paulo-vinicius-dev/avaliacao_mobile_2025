import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteGamesNotifier extends Notifier<List<String>> {
  @override
  List<String> build() {
    return [];
  }

  void toggleFavorite(String gameId) {
    if (state.contains(gameId)) {
      // Removi
      state = state.where((id) => id != gameId).toList();
    } else {
      // Adiciona
      state = [...state, gameId];
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
