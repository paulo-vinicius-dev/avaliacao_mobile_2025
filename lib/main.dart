import 'package:avaliacao_mobile_2025/screens/genre_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 255, 0, 0),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: MaterialApp(
        home: HomePage(),
        theme: theme,
      )
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Game Review"),
        centerTitle: true,
      ),
      bottomNavigationBar: TabBar(
        tabs: [
          Tab(icon: Icon(Icons.home)),
          Tab(icon: Icon(Icons.videogame_asset)),
          Tab(icon: Icon(Icons.favorite))
        ]
      ),
      drawer: Drawer(),
      body: const GenreScreen(),
    );
  }
}