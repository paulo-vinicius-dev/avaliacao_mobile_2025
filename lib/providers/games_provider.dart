import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:avaliacao_mobile_2025/models/game.dart';
import 'package:avaliacao_mobile_2025/data/dummy_data.dart';

class GamesNotifier extends Notifier<List<Game>> {
  @override
  List<Game> build() {
    return myGames;
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
  }
}

final gamesProvider = NotifierProvider<GamesNotifier, List<Game>>(
  GamesNotifier.new,
);
