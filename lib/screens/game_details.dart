import 'package:flutter/material.dart';
import 'package:avaliacao_mobile_2025/models/game.dart';

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
      ),
      body: Center( //adicionar mais detalhes e layout
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(game.imageUrl, height: 200),
            const SizedBox(height: 20),
            Text(
              'Detalhes sobre ${game.title}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.normal,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
