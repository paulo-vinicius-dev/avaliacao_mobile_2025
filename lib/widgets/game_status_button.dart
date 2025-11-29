import 'package:avaliacao_mobile_2025/models/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:avaliacao_mobile_2025/providers/games_provider.dart';

class GameStatusButton extends ConsumerWidget {
  const GameStatusButton({super.key, required this.game});

  final Game game;

  static const List<GameStatus> availableStatuses = [
    GameStatus.wishPlay,
    GameStatus.playing,
    GameStatus.concluded,
    GameStatus.dropped,
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: availableStatuses.map((status) {
        final isCurrentStatus = game.status == status;
        final statusColor = game.getStatusColor(status);
        final displayColor = isCurrentStatus
            ? statusColor.withValues(alpha: 0.5)
            : statusColor.withValues(alpha: 0.1);

        return GestureDetector(
          onTap: isCurrentStatus
              ? null
              : () {
            ref
                .read(gamesProvider.notifier)
                .updateGameStatus(game.id, status);

            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Status alterado para: ${game.getStatusDescription(status)}',
                ),
                duration: const Duration(seconds: 2),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: displayColor,
              border: Border.all(
                color: displayColor,
                width: isCurrentStatus ? 2.0 : 1.0,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              game.getStatusDescription(status),
              style: TextStyle(
                color: isCurrentStatus ? colorScheme.onSurface : colorScheme.onSurfaceVariant,
                fontWeight: isCurrentStatus
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}