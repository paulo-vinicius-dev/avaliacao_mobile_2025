import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:avaliacao_mobile_2025/models/user.dart';
import 'package:avaliacao_mobile_2025/models/game.dart';
import 'package:avaliacao_mobile_2025/models/genre.dart';
import 'package:flutter/material.dart';

class FirestoreService {
  final _firestore = FirebaseFirestore.instance;

  CollectionReference get _users => _firestore.collection('users');
  CollectionReference get _games => _firestore.collection('games');
  CollectionReference get _genres => _firestore.collection('genres');
  CollectionReference get _userGames => _firestore.collection('user_games');

  // ==================== USERS ====================

  Future<void> createUser(User user) async {
    await _users.doc(user.id).set({
      'name': user.name,
      'email': user.email,
      'profileImagePath': user.profileImagePath,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<User?> getUserById(String uid) async {
    final doc = await _users.doc(uid).get();
    if (!doc.exists) return null;
    final data = doc.data() as Map<String, dynamic>;
    return User(
      id: doc.id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      profileImagePath: data['profileImagePath'],
    );
  }

  Future<void> updateProfileImage(String uid, String? path) async {
    await _users.doc(uid).update({'profileImagePath': path});
  }

  // ==================== GAMES ====================

  Future<List<Game>> getAllGames() async {
    final snapshot = await _games.get();
    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return Game(
        id: data['id'] ?? doc.id,
        title: data['title'] ?? '',
        imageUrl: data['imageUrl'] ?? '',
        genres: List<int>.from(data['genres'] ?? []),
        releaseDate: (data['releaseDate'] as Timestamp).toDate(),
        platforms: List<String>.from(data['platforms'] ?? []),
        synopsis: data['synopsis'] ?? '',
      );
    }).toList();
  }

  Future<Game?> getGameById(String gameId) async {
    final doc = await _games.doc(gameId).get();
    if (!doc.exists) return null;
    final data = doc.data() as Map<String, dynamic>;
    return Game(
      id: data['id'] ?? doc.id,
      title: data['title'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      genres: List<int>.from(data['genres'] ?? []),
      releaseDate: (data['releaseDate'] as Timestamp).toDate(),
      platforms: List<String>.from(data['platforms'] ?? []),
      synopsis: data['synopsis'] ?? '',
    );
  }

  // ==================== GENRES ====================

  Future<List<Genre>> getAllGenres() async {
    final snapshot = await _genres.orderBy('id').get();
    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return Genre(
        id: data['id'] ?? 0,
        title: data['title'] ?? '',
        color: Color(data['color'] ?? 0xFF000000),
      );
    }).toList();
  }

  Future<Genre?> getGenreById(int genreId) async {
    final doc = await _genres.doc(genreId.toString()).get();
    if (!doc.exists) return null;
    final data = doc.data() as Map<String, dynamic>;
    return Genre(
      id: data['id'] ?? 0,
      title: data['title'] ?? '',
      color: Color(data['color'] ?? 0xFF000000),
    );
  }

  // ==================== USER_GAMES (Associativa) ====================

  /// Adiciona ou atualiza a relação usuário-jogo
  Future<void> saveUserGame({
    required String userId,
    required String gameId,
    required bool isFavorite,
    required GameStatus status,
  }) async {
    final docId = '${userId}_$gameId';
    await _userGames.doc(docId).set({
      'userId': userId,
      'gameId': gameId,
      'isFavorite': isFavorite,
      'status': status.name,
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  /// Remove a relação usuário-jogo
  Future<void> removeUserGame(String userId, String gameId) async {
    final docId = '${userId}_$gameId';
    await _userGames.doc(docId).delete();
  }

  /// Busca todos os jogos favoritos de um usuário
  Future<List<String>> getUserFavoriteGameIds(String userId) async {
    final snapshot = await _userGames
        .where('userId', isEqualTo: userId)
        .where('isFavorite', isEqualTo: true)
        .get();
    
    return snapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .map((data) => data['gameId'] as String)
        .toList();
  }

  /// Busca todos os status de jogos de um usuário
  Future<Map<String, GameStatus>> getUserGameStatuses(String userId) async {
    final snapshot = await _userGames
        .where('userId', isEqualTo: userId)
        .get();
    
    final Map<String, GameStatus> statuses = {};
    for (final doc in snapshot.docs) {
      final data = doc.data() as Map<String, dynamic>;
      final gameId = data['gameId'] as String;
      final statusName = data['status'] as String?;
      
      if (statusName != null) {
        statuses[gameId] = GameStatus.values.firstWhere(
          (e) => e.name == statusName,
          orElse: () => GameStatus.notStarted,
        );
      }
    }
    
    return statuses;
  }

  /// Atualiza apenas o status de um jogo
  Future<void> updateUserGameStatus({
    required String userId,
    required String gameId,
    required GameStatus status,
  }) async {
    final docId = '${userId}_$gameId';
    await _userGames.doc(docId).update({
      'status': status.name,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  /// Atualiza apenas se é favorito
  Future<void> updateUserGameFavorite({
    required String userId,
    required String gameId,
    required bool isFavorite,
  }) async {
    final docId = '${userId}_$gameId';
    
    if (isFavorite) {
      await _userGames.doc(docId).set({
        'userId': userId,
        'gameId': gameId,
        'isFavorite': true,
        'status': GameStatus.notStarted.name,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } else {
      // Se não é mais favorito e não tem outros dados, remove
      final doc = await _userGames.doc(docId).get();
      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        final status = data['status'] as String?;
        
        if (status == null || status == GameStatus.notStarted.name) {
          await _userGames.doc(docId).delete();
        } else {
          await _userGames.doc(docId).update({
            'isFavorite': false,
            'updatedAt': FieldValue.serverTimestamp(),
          });
        }
      }
    }
  }
}
