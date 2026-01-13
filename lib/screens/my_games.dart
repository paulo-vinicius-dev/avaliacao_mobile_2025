import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:avaliacao_mobile_2025/widgets/game_card.dart';
import 'package:avaliacao_mobile_2025/models/game.dart';
import 'package:avaliacao_mobile_2025/screens/game_details.dart';
import 'package:avaliacao_mobile_2025/providers/favorite_games_provider.dart';
import 'package:avaliacao_mobile_2025/providers/grid_layout_provider.dart';

class MyGamesScreen extends ConsumerWidget {
  const MyGamesScreen({super.key, required this.allGames});

  final List<Game> allGames;

  void showGameDetails(BuildContext context, Game game) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (ctx) => GameDetailsScreen(game: game)));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteGamesIds = ref.watch(favoriteGamesProvider);

    final axisCount = ref.watch(gridLayoutProvider);

    final favoriteGames = allGames.where((game) {
      return favoriteGamesIds.contains(game.id);
    }).toList();

    if (favoriteGames.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.favorite_border, size: 80, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'Nenhum jogo favorito',
              style: Theme.of(
                context,
              ).textTheme.titleLarge!.copyWith(color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Text(
              'Adicione jogos aos favoritos na tela de gêneros',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium!.copyWith(color: Colors.grey[500]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(12.0),
      itemCount: favoriteGames.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: axisCount,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: axisCount == 1 ? 2 : 0.7,
      ),
      itemBuilder: (context, index) {
        final game = favoriteGames[index];
        return Stack(
          children: [
            GameCards(
              game: game,
              onTap: (game) {
                showGameDetails(context, game);
              },
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.6),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                  tooltip: 'Remover dos favoritos',
                  onPressed: () {
                    ref.read(favoriteGamesProvider.notifier).toggleFavorite(game.id);

                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${game.title} removido dos favoritos'),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );

  }
}
