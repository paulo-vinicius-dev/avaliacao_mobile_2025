import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:avaliacao_mobile_2025/models/game.dart';
import 'package:avaliacao_mobile_2025/widgets/game_status_button.dart';
import 'package:avaliacao_mobile_2025/providers/games_provider.dart';

class GameDetailsScreen extends ConsumerStatefulWidget {
  final Game game;

  const GameDetailsScreen({super.key, required this.game});

  @override
  ConsumerState<GameDetailsScreen> createState() => _GameDetailsScreenState();
}

class _GameDetailsScreenState extends ConsumerState<GameDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    
    final games = ref.watch(gamesProvider);
    final currentGame = games.firstWhere(
      (g) => g.id == widget.game.id,
      orElse: () => widget.game,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(currentGame.title),
        backgroundColor: currentGame.getStatusColor(currentGame.status).withValues(alpha: 0.8),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              currentGame.imageUrl,
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currentGame.title,
                    style: textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Lançamento: ${currentGame.getReleaseDateFormated()}',
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (currentGame.isFavorite) ...[
                    GameStatusButton(game: currentGame),
                    const SizedBox(height: 20),
                  ],
                  if (currentGame.platforms.isNotEmpty) ...[
                    Text(
                      'Plataformas',
                      style: textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: currentGame.platforms.map((platform) {
                        return Chip(
                          label: Text(platform),
                          backgroundColor: colorScheme.primaryContainer,
                          labelStyle: TextStyle(
                            color: colorScheme.onPrimaryContainer,
                          ),
                          side: BorderSide.none,
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),
                  ],
                  if (currentGame.synopsis.isNotEmpty) ...[
                    Text(
                      'Sinopse',
                      style: textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      currentGame.synopsis,
                      style: textTheme.bodyLarge?.copyWith(
                        color: colorScheme.onSurface,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}