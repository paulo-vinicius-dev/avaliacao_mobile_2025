import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:avaliacao_mobile_2025/models/game.dart';
import 'package:avaliacao_mobile_2025/providers/games_provider.dart';
import 'package:avaliacao_mobile_2025/providers/auth_provider.dart';
import 'package:avaliacao_mobile_2025/services/firestore_service.dart';

class FavoriteGamesNotifier extends AsyncNotifier<List<String>> {
  final _firestoreService = FirestoreService();
  String? _currentUserId;

  @override
  Future<List<String>> build() async {
    final authState = ref.watch(authProvider);
    if (authState.isAuthenticated && authState.user != null) {
      _currentUserId = authState.user!.id;
      return await _loadFavorites();
    }
    return [];
  }

  Future<List<String>> _loadFavorites() async {
    if (_currentUserId == null) return [];
    
    try {
      return await _firestoreService.getUserFavoriteGameIds(_currentUserId!);
    } catch (e) {
      print('Erro ao carregar favoritos: $e');
      return [];
    }
  }

  Future<void> loadUserFavorites(String? username) async {
    if (_currentUserId == null) return;
    
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _loadFavorites());
  }

  Future<void> toggleFavorite(String gameId) async {
    if (_currentUserId == null) return;

    state.whenData((favorites) async {
      final isFav = favorites.contains(gameId);
      
      try {
        if (isFav) {
          // Remove favorito
          await _firestoreService.updateUserGameFavorite(
            userId: _currentUserId!,
            gameId: gameId,
            isFavorite: false,
          );
          
          state = AsyncValue.data(
            favorites.where((id) => id != gameId).toList(),
          );
          
          ref.read(gamesProvider.notifier).updateGameStatus(
            gameId,
            GameStatus.notStarted,
            isFavorite: false,
          );
        } else {
          // Adiciona favorito
          await _firestoreService.updateUserGameFavorite(
            userId: _currentUserId!,
            gameId: gameId,
            isFavorite: true,
          );
          
          state = AsyncValue.data([...favorites, gameId]);
          
          ref.read(gamesProvider.notifier).updateGameStatus(
            gameId,
            GameStatus.wishPlay,
            isFavorite: true,
          );
        }
      } catch (e) {
        print('Erro ao atualizar favorito: $e');
      }
    });
  }

  bool isFavorite(String gameId) {
    return state.when(
      data: (favorites) => favorites.contains(gameId),
      loading: () => false,
      error: (_, __) => false,
    );
  }
  
  void clearFavorites() {
    state = const AsyncValue.data([]);
  }
}

final favoriteGamesProvider =
  AsyncNotifierProvider<FavoriteGamesNotifier, List<String>>(() {
    return FavoriteGamesNotifier();
});