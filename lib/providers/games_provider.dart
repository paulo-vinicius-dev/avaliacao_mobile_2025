import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:avaliacao_mobile_2025/models/game.dart';
import 'package:avaliacao_mobile_2025/services/firestore_service.dart';
import 'package:avaliacao_mobile_2025/providers/auth_provider.dart';

class GamesNotifier extends AsyncNotifier<List<Game>> {
  final _firestoreService = FirestoreService();
  Map<String, GameStatus> _cachedStatuses = {};
  List<String> _cachedFavorites = [];
  String? _currentUserId;

  @override
  Future<List<Game>> build() async {
    final authState = ref.watch(authProvider);
    if (authState.isAuthenticated && authState.user != null) {
      _currentUserId = authState.user!.id;

      try {
        _cachedStatuses = await _firestoreService.getUserGameStatuses(_currentUserId!);
        _cachedFavorites = await _firestoreService.getUserFavoriteGameIds(_currentUserId!);
      } catch (e) {
        print('Erro ao carregar preferências no build: $e');
      }
    } else {

      _currentUserId = null;
      _cachedStatuses = {};
      _cachedFavorites = [];
    }
    return await _loadGames();
  }

  Future<List<Game>> _loadGames() async {
    try {
      final games = await _firestoreService.getAllGames();
      
      return [
        for (final game in games)
          Game(
            id: game.id,
            title: game.title,
            imageUrl: game.imageUrl,
            genres: game.genres,
            releaseDate: game.releaseDate,
            status: _cachedStatuses[game.id] ?? GameStatus.notStarted,
            isFavorite: _cachedFavorites.contains(game.id),
            hoursPlayed: game.hoursPlayed,
            platforms: game.platforms,
            synopsis: game.synopsis,
          )
      ];
    } catch (e) {
      print('Erro ao carregar games: $e');
      return [];
    }
  }

  void setUsername(String? username) {
    // Não mais necessário - usa userId do authProvider
  }

  Future<void> loadUserGames(String? username) async {
    if (_currentUserId == null) return;
    
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      _cachedStatuses = await _firestoreService.getUserGameStatuses(_currentUserId!);
      _cachedFavorites = await _firestoreService.getUserFavoriteGameIds(_currentUserId!);
      
      return await _loadGames();
    });
  }

  void updateGameStatus(
      String gameId,
      GameStatus newStatus, {
        bool isFavorite = true,
      }) {
    if (_currentUserId == null) return;

    state.whenData((games) async {
      final updatedGames = [
        for (final game in games)
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
      state = AsyncValue.data(updatedGames);
      
      // Salvar no Firebase
      try {
        await _firestoreService.saveUserGame(
          userId: _currentUserId!,
          gameId: gameId,
          isFavorite: isFavorite,
          status: newStatus,
        );
      } catch (e) {
        print('Erro ao salvar status: $e');
      }
    });
  }
}

final gamesProvider = AsyncNotifierProvider<GamesNotifier, List<Game>>(() {
  return GamesNotifier();
});