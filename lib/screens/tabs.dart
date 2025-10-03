import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:avaliacao_mobile_2025/data/dummy_data.dart';
import 'package:avaliacao_mobile_2025/screens/my_games.dart';
import 'package:avaliacao_mobile_2025/screens/genre_screen.dart';

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

  @override
  Widget build(BuildContext context) {
    Widget activePage = MyGamesScreen(myGames: myGames);
    var activePageTitle = 'Meus Jogos';
    if (_selectedPageIndex == 1) {
      //definir cada tela da navibar
      activePage = GenreScreen(genres: genres, games: myGames);
      activePageTitle = 'Gêneros';
    }

    return Scaffold(
      appBar: AppBar(title: Text(activePageTitle), centerTitle: true),
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
          BottomNavigationBarItem(
            icon: Icon(Icons.stacked_bar_chart),
            label: 'Estatísticas',
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ListTile(leading: Icon(Icons.info_outline), title: Text('Sobre')),
          ],
        ),
      ),
    );
  }
}
