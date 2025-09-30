import 'package:flutter/material.dart';

import 'package:avaliacao_mobile_2025/models/genre.dart';
import 'package:avaliacao_mobile_2025/models/game.dart';
import 'package:avaliacao_mobile_2025/models/review.dart';

const genres = [
  Genre(
    id: 1,
    title: "Ação",
    color: Colors.red,
  ),
  Genre(
    id: 2,
    title: "Aventura",
    color: Colors.green,
  ),
  Genre(
    id: 3,
    title: "RPG",
    color: Colors.blue,
  ),
  Genre(
    id: 4,
    title: "Esportes",
    color: Colors.yellow,
  ),
  Genre(
    id: 5,
    title: "Estratégia",
    color: Colors.purple,
  ),
  Genre(
    id: 6,
    title: "Simulação",
    color: Colors.orange,
  ),
];

List<Game> games = [
  Game(
    id: 1,
    genreId: 1,
    title: "God Of War (2018)",
    imageUrl: "",
    releaseDate: DateTime(2018, 4, 20),
  ),
  Game(
    id: 2,
    genreId: 2,
    title: "Uncharted 4: A Thief's End",
    imageUrl: "",
    releaseDate: DateTime(2016, 5, 10),
  ),
  Game(
    id: 3,
    genreId: 3,
    title: "The Legend of Zelda: Breath of the Wild",
    imageUrl: "",
    releaseDate: DateTime(2017, 3, 3),
  ),
  Game(
    id: 4,
    genreId: 4,
    title: "EA Sports FC 25",
    imageUrl: "",
    releaseDate: DateTime(2025, 9, 26),
  ),  Game(
    id: 5,
    genreId: 1,
    title: "Spider-Man 2",
    imageUrl: "",
    releaseDate: DateTime(2023, 10, 20),
  ),
  Game(
    id: 6,
    genreId: 2,
    title: "Horizon Zero Dawn",
    imageUrl: "",
    releaseDate: DateTime(2017, 2, 28),
  ),
  Game(
    id: 7,
    genreId: 3,
    title: "Final Fantasy VII Remake",
    imageUrl: "",
    releaseDate: DateTime(2020, 4, 10),
  ),
  Game(
    id: 8,
    genreId: 5,
    title: "Civilization VI",
    imageUrl: "",
    releaseDate: DateTime(2016, 10, 21),
  ),
  Game(
    id: 9,
    genreId: 6,
    title: "The Sims 4",
    imageUrl: "",
    releaseDate: DateTime(2014, 9, 2),
  ),
  Game(
    id: 10,
    genreId: 1,
    title: "Doom Eternal",
    imageUrl: "",
    releaseDate: DateTime(2020, 3, 20),
  ),
    Game(
    id: 11,
    genreId: 2,
    title: "Mineirinho Ultra Adventures",
    imageUrl: "",
    releaseDate: DateTime(2017, 1, 27),
  ),
];

const reviews = [
  Reviews(
    id: 1,
    gameId: 1,
    rating: 4,
    comment: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
  ),
  Reviews(
    id: 2,
    gameId: 1,
    rating: 5,
    comment: "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
  ),
  Reviews(
    id: 3,
    gameId: 2,
    rating: 4,
    comment: "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
  ),
  Reviews(
    id: 4,
    gameId: 3,
    rating: 5,
    comment: "Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
  ),
  Reviews(
    id: 5,
    gameId: 4,
    rating: 3,
    comment: "Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.",
  ),
  Reviews(
    id: 6,
    gameId: 5,
    rating: 4,
    comment: "Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem.",
  ),
  Reviews(
    id: 7,
    gameId: 6,
    rating: 4,
    comment: "Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?",
  ),
  Reviews(
    id: 8,
    gameId: 7,
    rating: 4,
    comment: "At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos"
  ),
];