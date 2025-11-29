import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:avaliacao_mobile_2025/models/game.dart';
import 'package:avaliacao_mobile_2025/data/dummy_data.dart';
import 'package:avaliacao_mobile_2025/providers/local_storage.dart';

class GamesNotifier extends Notifier<List<Game>> {
  // Injeção
  final Map<String, GameStatus> _initialStatuses;
  final List<String> _initialFavorites;
  final _storage = LocalStorage();

  GamesNotifier(this._initialStatuses, this._initialFavorites);

  @override
  List<Game> build() {
    // Reconstrói a lista inicial baseada no Dummy Data + Arquivos Salvos
    return [
      for (final game in myGames)
        Game(
          id: game.id,
          title: game.title,
          imageUrl: game.imageUrl,
          genres: game.genres,
          releaseDate: game.releaseDate,
          // Aplica o status salvo ou o padrão
          status: _initialStatuses[game.id] ?? game.status,
          // Aplica o favorito salvo
          isFavorite: _initialFavorites.contains(game.id),
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
    // salvar status no disco
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

// Inicializa vazio, sobrescrito no main
final gamesProvider = NotifierProvider<GamesNotifier, List<Game>>(() {
  return GamesNotifier({}, []);
});