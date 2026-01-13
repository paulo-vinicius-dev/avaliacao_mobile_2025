import 'package:avaliacao_mobile_2025/models/game.dart' as models;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:avaliacao_mobile_2025/providers/games_provider.dart';

class GameStatusButton extends ConsumerWidget {
  const GameStatusButton({super.key, required this.game});

  final models.Game game;

  static const List<models.GameStatus> availableStatuses = [
    models.GameStatus.playing,
    models.GameStatus.concluded,
    models.GameStatus.wishPlay,
    models.GameStatus.dropped,
  ];

  Color _getStatusColor(models.GameStatus status) {
    switch (status) {
      case models.GameStatus.notStarted:
        return Colors.grey;
      case models.GameStatus.playing:
        return Colors.blue;
      case models.GameStatus.concluded:
        return Colors.green;
      case models.GameStatus.wishPlay:
        return Colors.yellow.shade800;
      case models.GameStatus.dropped:
        return Colors.red;
    }
  }

  String _getStatusDescription(models.GameStatus status) {
    switch (status) {
      case models.GameStatus.notStarted:
        return 'Não iniciado';
      case models.GameStatus.playing:
        return 'Em progresso';
      case models.GameStatus.concluded:
        return 'Concluído';
      case models.GameStatus.wishPlay:
        return 'Desejo jogar';
      case models.GameStatus.dropped:
        return 'Aposentado';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: availableStatuses.map((status) {
        final isCurrentStatus = game.status == status;
        final statusColor = _getStatusColor(status);
        final displayColor = isCurrentStatus
            ? statusColor
            : statusColor.withValues(alpha: 0.3);

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
                  'Status alterado para: ${_getStatusDescription(status)}',
                ),
                duration: const Duration(seconds: 2),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: displayColor.withValues(alpha: 0.2),
              border: Border.all(
                color: displayColor,
                width: isCurrentStatus ? 2.0 : 1.0,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              _getStatusDescription(status),
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