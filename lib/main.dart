import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:avaliacao_mobile_2025/screens/tabs.dart';


final theme = ThemeData(
  textTheme: GoogleFonts.robotoTextTheme(),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(252, 33, 8, 85),
    foregroundColor: Colors.white,
  ),
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 31, 5, 76),
  ),
);

void main() {
  runApp(
    const ProviderScope (
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: const TabsScreen(),
    );
  }
}
