import 'package:flutter/material.dart';
import 'package:avaliacao_mobile_2025/models/game.dart';

class GameCards extends StatelessWidget {
  const GameCards({
    super.key,
    required this.game,
    required this.onTap,
  });

  final Game game;
  final void Function(Game game) onTap;//função atributo para seleção do jogo

  // Função pra definir cor da borda de acordo com status
  Color _getBorderColor(gameStatus status) {
    switch (status) {
      case gameStatus.Jogando:
        return Colors.deepOrange;
      case gameStatus.Concluido:
        return Colors.lightGreen;
      case gameStatus.DesejoIniciar:
        return Colors.deepPurple;
      case gameStatus.Aposentado:
        return Colors.grey;
      default:
        return Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onTap(game);
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
          side: BorderSide(
            color: _getBorderColor(game.status),
            width: 1,
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
                errorBuilder: (context, error, stackTrace) { //exibe icone caso imagem n esteja dosponivel
                  return const Center(
                    child: Icon(Icons.broken_image, size: 40, color: Colors.grey),
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                game.title,
                style: const TextStyle(
                  color: Colors.white,
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
