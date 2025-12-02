import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:avaliacao_mobile_2025/providers/theme_provider.dart';
import 'package:avaliacao_mobile_2025/providers/grid_layout_provider.dart';
import 'package:avaliacao_mobile_2025/providers/games_provider.dart';
import 'package:avaliacao_mobile_2025/providers/favorite_games_provider.dart';

class AuthState {
  final bool isAuthenticated;
  final String? username;

  AuthState({
    required this.isAuthenticated,
    this.username,
  });

  AuthState.unauthenticated()
      : isAuthenticated = false,
        username = null;

  AuthState.authenticated(this.username) : isAuthenticated = true;
}

class AuthNotifier extends Notifier<AuthState> {
  static const _authKey = 'isAuthenticated';
  static const _usernameKey = 'username';

  static const Map<String, String> _validUsers = {
    'paulo': 'senhapaulo123',
    'elder': 'senhaelder123',
  };

  @override
  AuthState build() {
    return AuthState.unauthenticated();
  }

  Future<void> _loadUserPreferences(String username) async {
    // Carregar preferências do usuário
    await ref.read(themeProvider.notifier).loadUserTheme(username);
    await ref.read(gridLayoutProvider.notifier).loadUserLayout(username);
    await ref.read(favoriteGamesProvider.notifier).loadUserFavorites(username);
    await ref.read(gamesProvider.notifier).loadUserGames(username);
  }

  Future<bool> login(String username, String password) async {
    if (_validUsers[username] == password) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_authKey, true);
      await prefs.setString(_usernameKey, username);
      
      // Carregar preferências do usuário antes de atualizar o estado
      await _loadUserPreferences(username);
      
      state = AuthState.authenticated(username);
      
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_authKey);
    await prefs.remove(_usernameKey);
    
    // Limpar favoritos ao fazer logout
    ref.read(favoriteGamesProvider.notifier).clearFavorites();
    
    state = AuthState.unauthenticated();
  }

  Future<void> checkAuthStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isAuth = prefs.getBool(_authKey) ?? false;
    final username = prefs.getString(_usernameKey);

    if (isAuth && username != null) {
      // Carregar preferências do usuário
      await _loadUserPreferences(username);
      state = AuthState.authenticated(username);
    } else {
      state = AuthState.unauthenticated();
    }
  }
}

final authProvider = NotifierProvider<AuthNotifier, AuthState>(() {
  return AuthNotifier();
});