import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:avaliacao_mobile_2025/models/game.dart';
import 'package:avaliacao_mobile_2025/models/genre.dart';
import 'package:avaliacao_mobile_2025/widgets/game_card.dart';
import 'package:avaliacao_mobile_2025/screens/game_details.dart';
import 'package:avaliacao_mobile_2025/providers/favorite_games_provider.dart';

class GamesListScreen extends ConsumerWidget {
  const GamesListScreen({super.key, required this.genre, required this.games});

  final Genre genre;
  final List<Game> games;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteGames = ref.watch(favoriteGamesProvider);
    final favoriteNotifier = ref.read(favoriteGamesProvider.notifier);

    final filteredGames = games.where((game) {
      return game.genres.contains(genre.id);
    }).toList();

    return Scaffold(
      appBar: AppBar(title: Text(genre.title), backgroundColor: genre.color),
      body: filteredGames.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.gamepad_outlined,
                    size: 80,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Nenhum jogo encontrado',
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge!.copyWith(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Não há jogos do gênero ${genre.title}',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium!.copyWith(color: Colors.grey[500]),
                  ),
                ],
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: filteredGames.length,
              itemBuilder: (context, index) {
                final game = filteredGames[index];
                final isFavorite = favoriteGames.contains(game.id);

                return Stack(
                  children: [
                    GameCards(
                      game: game,
                      onTap: (game) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => GameDetailsScreen(game: game),
                          ),
                        );
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
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : Colors.white,
                          ),
                          onPressed: () {
                            favoriteNotifier.toggleFavorite(game.id);
                            
                            ScaffoldMessenger.of(context).clearSnackBars();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  isFavorite
                                      ? '${game.title} removido dos favoritos'
                                      : '${game.title} adicionado aos favoritos',
                                ),
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
            ),
    );
  }
}
