import 'package:flutter/material.dart';
import 'package:avaliacao_mobile_2025/models/game.dart';

class GameCards extends StatelessWidget {
  const GameCards({super.key, required this.game, required this.onTap});

  final Game game;
  final void Function(Game game) onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: () {
        onTap(game);
      },
      child: Card(
        elevation: 4,
        color: colorScheme.surfaceContainer,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
          side: BorderSide(
            color: game.getStatusColor(
              game.status,
            ),
            width: 2,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Expanded(
              child: Image.network(
                game.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Icon(
                      Icons.broken_image,
                      size: 40,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                game.title,
                style: TextStyle(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.normal,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}