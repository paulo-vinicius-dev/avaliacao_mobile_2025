import 'package:flutter/material.dart';
import 'package:avaliacao_mobile_2025/models/game.dart';
import 'package:avaliacao_mobile_2025/widgets/game_status_button.dart';

class GameDetailsScreen extends StatelessWidget {
  final Game game;

  const GameDetailsScreen({
    super.key,
    required this.game
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(game.title),
        backgroundColor: game.getStatusColor(game.status).withValues(alpha: 0.8),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              game.imageUrl,
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
                    game.title,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  
                  Text(
                    'Lançamento: ${game.getReleaseDateFormated()}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[400],
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  if (game.isFavorite) ...[
                    GameStatusButton(game: game),
                    const SizedBox(height: 20),
                  ],

                  if (game.platforms.isNotEmpty) ...[
                    Text(
                      'Plataformas',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: game.platforms.map((platform) {
                        return Chip(
                          label: Text(platform),
                          backgroundColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
                          labelStyle: const TextStyle(color: Colors.white),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),
                  ],
                  
                  // Sinopse
                  if (game.synopsis.isNotEmpty) ...[
                    Text(
                      'Sinopse',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      game.synopsis,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.white,
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
