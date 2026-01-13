import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:avaliacao_mobile_2025/providers/theme_provider.dart';
import 'package:avaliacao_mobile_2025/providers/grid_layout_provider.dart';
import 'package:avaliacao_mobile_2025/providers/games_provider.dart';
import 'package:avaliacao_mobile_2025/providers/favorite_games_provider.dart';
import 'package:avaliacao_mobile_2025/models/user.dart';

class AuthState {
  final bool isAuthenticated;
  final bool isLoading; // para evitar bug do inicio com usuario logado
  final User? user;

  AuthState({
    required this.isAuthenticated,
    this.isLoading = false,
    this.user,
  });

  AuthState.unauthenticated()
      : isAuthenticated = false,
        isLoading = false,
        user = null;

  AuthState.authenticated(this.user)
      : isAuthenticated = true,
        isLoading = false;

  AuthState.loading()
      : isAuthenticated = false,
        isLoading = true,
        user = null;
}

class AuthNotifier extends Notifier<AuthState> {
  static const _authKey = 'isAuthenticated';
  static const _currentUserEmailKey = 'currentUserEmail';
  static const _usersListKey = 'registeredUsers';

  @override
  AuthState build() {
    return AuthState.loading(); // Começa em estado de carregamento
  }

  Future<void> _loadUserPreferences(String username) async {
    await ref.read(themeProvider.notifier).loadUserTheme(username);
    await ref.read(gridLayoutProvider.notifier).loadUserLayout(username);
    await ref.read(favoriteGamesProvider.notifier).loadUserFavorites(username);
    await ref.read(gamesProvider.notifier).loadUserGames(username);
  }

  Future<bool> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final usersJson = prefs.getStringList(_usersListKey) ?? [];

    for (var userJson in usersJson) {
      final userData = json.decode(userJson);
      if (userData['email'] == email && userData['password'] == password) {
        final user = User.fromMap(userData);

        await prefs.setBool(_authKey, true);
        await prefs.setString(_currentUserEmailKey, email);

        await _loadUserPreferences(user.name);
        state = AuthState.authenticated(user);
        return true;
      }
    }
    return false;
  }

  Future<bool> register(String username, String email, String password, {String? profileImagePath}) async {
    final prefs = await SharedPreferences.getInstance();
    final usersJson = prefs.getStringList(_usersListKey) ?? [];

    for (var userJson in usersJson) {
      final userData = json.decode(userJson);
      if (userData['email'] == email) return false;
    }

    final newUser = {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'name': username,
      'email': email,
      'password': password,
      'profileImagePath': profileImagePath,
      'favoriteGamesIds': [],
    };

    usersJson.add(json.encode(newUser));
    await prefs.setStringList(_usersListKey, usersJson);

    return await login(email, password);
  }

  Future<void> updateProfileImage(String? path) async {
    if (state.user == null) return;

    final prefs = await SharedPreferences.getInstance();
    final usersJson = prefs.getStringList(_usersListKey) ?? [];
    final updatedUsers = <String>[];

    User? updatedUser;

    for (var userJson in usersJson) {
      final userData = json.decode(userJson);
      if (userData['email'] == state.user!.email) {
        userData['profileImagePath'] = path;
        updatedUser = User.fromMap(userData);
        updatedUsers.add(json.encode(userData));
      } else {
        updatedUsers.add(userJson);
      }
    }

    await prefs.setStringList(_usersListKey, updatedUsers);
    if (updatedUser != null) {
      state = AuthState.authenticated(updatedUser);
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_authKey);
    await prefs.remove(_currentUserEmailKey);

    ref.read(favoriteGamesProvider.notifier).clearFavorites();
    state = AuthState.unauthenticated();
  }

  Future<void> checkAuthStatus() async {
    state = AuthState.loading();
    final prefs = await SharedPreferences.getInstance();
    final isAuth = prefs.getBool(_authKey) ?? false;
    final email = prefs.getString(_currentUserEmailKey);

    if (isAuth && email != null) {
      final usersJson = prefs.getStringList(_usersListKey) ?? [];
      for (var userJson in usersJson) {
        final userData = json.decode(userJson);
        if (userData['email'] == email) {
          final user = User.fromMap(userData);
          await _loadUserPreferences(user.name);
          state = AuthState.authenticated(user);
          return;
        }
      }
    }
    state = AuthState.unauthenticated();
  }
}

final authProvider = NotifierProvider<AuthNotifier, AuthState>(() {
  return AuthNotifier();
});
