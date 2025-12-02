import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<bool> login(String username, String password) async {
    if (_validUsers[username] == password) {
      state = AuthState.authenticated(username);
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_authKey, true);
      await prefs.setString(_usernameKey, username);
      
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_authKey);
    await prefs.remove(_usernameKey);
    
    state = AuthState.unauthenticated();
  }

  Future<void> checkAuthStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isAuth = prefs.getBool(_authKey) ?? false;
    final username = prefs.getString(_usernameKey);

    if (isAuth && username != null) {
      state = AuthState.authenticated(username);
    } else {
      state = AuthState.unauthenticated();
    }
  }
}

final authProvider = NotifierProvider<AuthNotifier, AuthState>(() {
  return AuthNotifier();
});