import 'package:flutter/material.dart';

enum GameStatus { notStarted, playing, concluded, wishPlay, dropped }

class Game {
  Game({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.genres,
    required this.releaseDate,
    this.status = GameStatus.notStarted,
    this.isFavorite = false,
    this.hoursPlayed = 0,
    this.platforms = const [],
    this.synopsis = '',
  });

  final String id;
  final String title;
  final String imageUrl;
  final List<int> genres;
  final DateTime releaseDate;
  GameStatus status;
  bool isFavorite;
  num hoursPlayed;
  final List<String> platforms;
  final String synopsis;

  Color getStatusColor(GameStatus status) {
    switch (status) {
      case GameStatus.notStarted:
        return Colors.grey;
      case GameStatus.playing:
        return Colors.blue;
      case GameStatus.concluded:
        return Colors.green;
      case GameStatus.wishPlay:
        return Colors.deepPurple;
      case GameStatus.dropped:
        return Colors.red;
    }
  }

  String getStatusDescription(GameStatus status) {
    switch (status) {
      case GameStatus.notStarted:
        return 'Não iniciado';
      case GameStatus.playing:
        return 'Jogando';
      case GameStatus.concluded:
        return 'Concluído';
      case GameStatus.wishPlay:
        return 'Deseja jogar';
      case GameStatus.dropped:
        return 'Abandonado';
    }
  }

  String getReleaseDateFormated() {
    final day = releaseDate.day.toString().padLeft(2, '0');
    final month = releaseDate.month.toString().padLeft(2, '0');
    final year = releaseDate.year.toString();
    return '$day/$month/$year';
  }
}
