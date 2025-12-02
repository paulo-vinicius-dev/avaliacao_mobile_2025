import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:avaliacao_mobile_2025/screens/tabs.dart';
import 'package:avaliacao_mobile_2025/screens/login_screen.dart';
import 'package:avaliacao_mobile_2025/providers/theme_provider.dart';
import 'package:avaliacao_mobile_2025/providers/auth_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:avaliacao_mobile_2025/providers/grid_layout_provider.dart';
import 'package:avaliacao_mobile_2025/providers/local_storage.dart';
import 'package:avaliacao_mobile_2025/providers/games_provider.dart';
import 'package:avaliacao_mobile_2025/providers/favorite_games_provider.dart';

const seedColor = Color.fromARGB(255, 31, 5, 76);
final textTheme = GoogleFonts.robotoTextTheme();

final lightTheme = ThemeData(
  textTheme: textTheme,
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(252, 115, 60, 237),
    foregroundColor: Colors.white,
  ),
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.light,
    seedColor: seedColor,
  ),
);

final darkTheme = ThemeData(
  textTheme: textTheme,
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(252, 33, 8, 85),
    foregroundColor: Colors.white,
  ),
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: seedColor,
  ),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storage = LocalStorage();
  final initialFavorites = await storage.readFavorites();
  final initialStatuses = await storage.readStatuses();

  final prefs = await SharedPreferences.getInstance();
  final savedThemeString = prefs.getString('themeMode');

  final savedColumns = prefs.getInt('gridLayout_columns') ?? 3;

  ThemeMode initialTheme = ThemeMode.system;
  if (savedThemeString != null) {
    if (savedThemeString == 'ThemeMode.dark') {
      initialTheme = ThemeMode.dark;
    } else if (savedThemeString == 'ThemeMode.light') {
      initialTheme = ThemeMode.light;
    }
  }
  
  runApp(
    ProviderScope(
      overrides: [
        favoriteGamesProvider.overrideWith(() {
          return FavoriteGamesNotifier(initialFavorites);
        }),
        gamesProvider.overrideWith(() {
          return GamesNotifier(initialStatuses, initialFavorites);
        }),
        themeProvider.overrideWith(() {
          return _InitializedThemeNotifier(initialTheme);
        }),
        gridLayoutProvider.overrideWith(() {
          return GridLayoutNotifier(savedColumns);
        }),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(authProvider.notifier).checkAuthStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentThemeMode = ref.watch(themeProvider);
    final authState = ref.watch(authProvider);

    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: currentThemeMode,
      home: authState.isAuthenticated ? const TabsScreen() : const LoginScreen(),
    );
  }
}

class _InitializedThemeNotifier extends ThemeNotifier {
  final ThemeMode initialTheme;
  _InitializedThemeNotifier(this.initialTheme);

  @override
  ThemeMode build() {
    return initialTheme;
  }
}
