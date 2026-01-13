import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:avaliacao_mobile_2025/data/dummy_data.dart';
import 'package:avaliacao_mobile_2025/screens/my_games.dart';
import 'package:avaliacao_mobile_2025/screens/genre_screen.dart';
import 'package:avaliacao_mobile_2025/screens/profile_screen.dart';
import 'package:avaliacao_mobile_2025/widgets/main_drawer.dart';
import 'package:avaliacao_mobile_2025/screens/about.dart';
import 'package:avaliacao_mobile_2025/providers/games_provider.dart';
import 'package:avaliacao_mobile_2025/providers/grid_layout_provider.dart';

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
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (ctx) => const AboutScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final games = ref.watch(gamesProvider);
    final currentCols = ref.watch(gridLayoutProvider);

    Widget activePage = MyGamesScreen(allGames: games);
    var activePageTitle = 'Meus Jogos';
    bool showLayoutAction = true;

    if (_selectedPageIndex == 1) {
      activePage = GenreScreen(genres: genres, games: games);
      activePageTitle = 'Gêneros';
      showLayoutAction = false;
    } else if (_selectedPageIndex == 2) {
      activePage = const ProfileScreen();
      activePageTitle = 'Perfil';
      showLayoutAction = false;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
        centerTitle: true,
        actions: [
          if (showLayoutAction)
            IconButton(
              icon: Icon(
                currentCols == 1
                    ? Icons.view_list
                    : (currentCols == 2 ? Icons.grid_view : Icons.grid_on_sharp),
              ),
              onPressed: () {
                ref.read(gridLayoutProvider.notifier).toggleColumns();
              },
              tooltip: 'Alterar visualização',
            ),
          const SizedBox(width: 8),
        ],
      ),
      drawer: MainDrawer(onSelectedScreen: _setScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.gamepad_outlined),
            label: 'Meus Jogos',
            activeIcon: Icon(Icons.gamepad),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category_outlined),
            label: 'Gêneros',
            activeIcon: Icon(Icons.category),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Perfil',
            activeIcon: Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}
