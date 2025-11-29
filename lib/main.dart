import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:avaliacao_mobile_2025/screens/tabs.dart';
import 'package:avaliacao_mobile_2025/providers/theme_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  final prefs = await SharedPreferences.getInstance();
  final savedThemeString = prefs.getString('themeMode');

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
        themeProvider.overrideWith(() {
          return _InitializedThemeNotifier(initialTheme);
        }),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentThemeMode = ref.watch(themeProvider);

    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: currentThemeMode,
      home: const TabsScreen(),
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
