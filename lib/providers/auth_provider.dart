import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:avaliacao_mobile_2025/providers/theme_provider.dart';
import 'package:avaliacao_mobile_2025/providers/grid_layout_provider.dart';
import 'package:avaliacao_mobile_2025/providers/favorite_games_provider.dart';
import 'package:avaliacao_mobile_2025/models/user.dart';
import 'package:avaliacao_mobile_2025/services/firestore_service.dart';

class AuthState {
  final bool isAuthenticated;
  final bool isLoading;
  final User? user;
  final String? errorMessage;

  AuthState({
    required this.isAuthenticated,
    this.isLoading = false,
    this.user,
    this.errorMessage,
  });

  AuthState.unauthenticated()
      : isAuthenticated = false,
        isLoading = false,
        user = null,
        errorMessage = null;

  AuthState.authenticated(this.user)
      : isAuthenticated = true,
        isLoading = false,
        errorMessage = null;

  AuthState.loading()
      : isAuthenticated = false,
        isLoading = true,
        user = null,
        errorMessage = null;

  AuthState.error(this.errorMessage)
      : isAuthenticated = false,
        isLoading = false,
        user = null;
}

class AuthNotifier extends Notifier<AuthState> {
  final _auth = fb_auth.FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn(
    scopes: ['email'],
    serverClientId: '547801780046-1pu5tcgmc33q0b5f72f8tkurndeer9i0.apps.googleusercontent.com',
  );
  final _firestoreService = FirestoreService();

  @override
  AuthState build() {
    _auth.authStateChanges().listen((fbUser) {
      if (fbUser != null) {
        _loadUserData(fbUser.uid);
      } else {
        if (state.isAuthenticated) {
          state = AuthState.unauthenticated();
        }
      }
    });
    return AuthState.loading();
  }

  Future<void> _loadUserData(String uid) async {
    final user = await _firestoreService.getUserById(uid);
    if (user != null) {
      await _loadUserPreferences(user.name);
      state = AuthState.authenticated(user);
    }
  }

  Future<void> _loadUserPreferences(String username) async {
    await ref.read(themeProvider.notifier).loadUserTheme(username);
    await ref.read(gridLayoutProvider.notifier).loadUserLayout(username);
    // favoriteGamesProvider e gamesProvider carregam automaticamente via watch(authProvider)
  }

  Future<bool> login(String email, String password) async {
    try {
      state = AuthState.loading();
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user != null) {
        await _loadUserData(credential.user!.uid);
        return true;
      }
      return false;
    } on fb_auth.FirebaseAuthException catch (e) {
      state = AuthState.error(_getErrorMessage(e.code));
      return false;
    }
  }

  Future<bool> loginWithGoogle() async {
    try {
      state = AuthState.loading();
      
      final googleUser = await _googleSignIn.signIn();
      
      if (googleUser == null) {
        state = AuthState.unauthenticated();
        return false;
      }

      final googleAuth = await googleUser.authentication;
      
      final credential = fb_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      
      if (userCredential.user != null) {
        // Verificar se é novo usuário
        final user = await _firestoreService.getUserById(userCredential.user!.uid);
        if (user == null) {
          // Criar novo usuário
          final newUser = User(
            id: userCredential.user!.uid,
            name: googleUser.displayName ?? googleUser.email,
            email: googleUser.email,
            profileImagePath: googleUser.photoUrl,
          );
          await _firestoreService.createUser(newUser);
        }
        await _loadUserData(userCredential.user!.uid);
        return true;
      }
      return false;
    } on fb_auth.FirebaseAuthException catch (e) {
      state = AuthState.error('Erro Firebase: ${e.message ?? e.code}');
      return false;
    } catch (e) {
      state = AuthState.error('Erro ao fazer login com Google: $e');
      return false;
    }
  }

  Future<bool> register(String username, String email, String password, {String? profileImagePath}) async {
    try {
      state = AuthState.loading();
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        final user = User(
          id: credential.user!.uid,
          name: username,
          email: email,
          profileImagePath: profileImagePath,
        );
        await _firestoreService.createUser(user);
        await _loadUserData(user.id);
        return true;
      }
      return false;
    } on fb_auth.FirebaseAuthException catch (e) {
      state = AuthState.error(_getErrorMessage(e.code));
      return false;
    }
  }

  Future<void> updateProfileImage(String? path) async {
    final current = state.user;
    if (current == null) return;

    await _firestoreService.updateProfileImage(current.id, path);
    final updated = User(
      id: current.id,
      name: current.name,
      email: current.email,
      profileImagePath: path,
    );
    state = AuthState.authenticated(updated);
  }

  Future<void> logout() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    ref.read(favoriteGamesProvider.notifier).clearFavorites();
    state = AuthState.unauthenticated();
  }

  Future<void> checkAuthStatus() async {
    state = AuthState.loading();
    final fbUser = _auth.currentUser;
    if (fbUser != null) {
      await _loadUserData(fbUser.uid);
    } else {
      state = AuthState.unauthenticated();
    }
  }

  String _getErrorMessage(String code) {
    switch (code) {
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return 'Usuário ou senha incorreto';
      case 'email-already-in-use':
        return 'Email já cadastrado';
      case 'weak-password':
        return 'Senha muito fraca (mínimo 6 caracteres)';
      case 'invalid-email':
        return 'Email inválido';
      default:
        return 'Erro ao autenticar: $code';
    }
  }
}

final authProvider = NotifierProvider<AuthNotifier, AuthState>(() {
  return AuthNotifier();
});
