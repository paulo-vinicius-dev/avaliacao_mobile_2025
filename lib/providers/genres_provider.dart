import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:avaliacao_mobile_2025/models/genre.dart';
import 'package:avaliacao_mobile_2025/services/firestore_service.dart';

class GenresNotifier extends AsyncNotifier<List<Genre>> {
  final _firestoreService = FirestoreService();

  @override
  Future<List<Genre>> build() async {
    return await _loadGenres();
  }

  Future<List<Genre>> _loadGenres() async {
    try {
      return await _firestoreService.getAllGenres();
    } catch (e) {
      print('Erro ao carregar genres(CORRIGIR BUG): $e');
      return [];
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _loadGenres());
  }
}

final genresProvider = AsyncNotifierProvider<GenresNotifier, List<Genre>>(() {
  return GenresNotifier();
});
