import 'package:flutter/material.dart';
import 'package:avaliacao_mobile_2025/widgets/game_card.dart';
import 'package:avaliacao_mobile_2025/models/game.dart';
import 'package:avaliacao_mobile_2025/screens/game_details.dart';

class MyGamesScreen extends StatelessWidget {
  const MyGamesScreen({
    super.key,
    required this.myGames,
  });

  final List<Game> myGames;

  void showGameDetails(BuildContext context, Game game) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => GameDetailsScreen(
          game: game,
        ),
      ),
    );
  }

  @override

    Widget build(BuildContext context) {
      return GridView.builder(
         padding: const EdgeInsets.all(12.0),
          itemCount: myGames.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // 3 colunas
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 0.7,
          ),
          itemBuilder: (context, index) {
            final game = myGames[index];
            return GameCards(
              game: game,
              onTap: (game) {
                showGameDetails(context, game);
              },
            );
            },
      );
    }
}