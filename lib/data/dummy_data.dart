import 'package:flutter/material.dart';

import 'package:avaliacao_mobile_2025/models/genre.dart';
import 'package:avaliacao_mobile_2025/models/game.dart';

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