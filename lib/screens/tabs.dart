import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:avaliacao_mobile_2025/data/dummy_data.dart';
import 'package:avaliacao_mobile_2025/screens/my_games.dart';
import 'package:avaliacao_mobile_2025/screens/genre_screen.dart';
import 'package:avaliacao_mobile_2025/widgets/main_drawer.dart';
import 'package:avaliacao_mobile_2025/screens/about.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'sobre') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => AboutScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = MyGamesScreen(allGames: myGames);
    var activePageTitle = 'Meus Jogos';
    if (_selectedPageIndex == 1) {
      //define cada tela da navibar
      activePage = GenreScreen(genres: genres, games: myGames);
      activePageTitle = 'Gêneros';
    }

    return Scaffold(
      appBar: AppBar(title: Text(activePageTitle), centerTitle: true),
      drawer: MainDrawer(onSelectedScreen: _setScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.gamepad_outlined),
            label: 'Meus Jogos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category_outlined),
            label: 'Gêneros',
          ),
          /* Implementar essa tela no futuro
          BottomNavigationBarItem(
            icon: Icon(Icons.stacked_bar_chart),
            label: 'Estatísticas',
          ),
          */
        ],
      ),
    );
  }
}

