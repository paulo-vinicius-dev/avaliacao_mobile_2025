import 'package:flutter/material.dart';
import 'package:avaliacao_mobile_2025/models/game.dart';
import 'package:avaliacao_mobile_2025/models/genre.dart';

const genres = [
  Genre(id: 1, title: "Ação", color: Colors.red),
  Genre(id: 2, title: "Aventura", color: Colors.green),
  Genre(id: 3, title: "RPG", color: Colors.blue),
  Genre(id: 4, title: "Esportes", color: Colors.yellow),
  Genre(id: 5, title: "Estratégia", color: Colors.purple),
  Genre(id: 6, title: "Simulação", color: Colors.orange),
  Genre(id: 7, title: "Mundo Aberto", color: Colors.teal),
  Genre(id: 8, title: "Plataforma", color: Colors.pink),
  Genre(id: 9, title: "Terror", color: Colors.black),
  Genre(id: 10, title: "FPS", color: Colors.brown),
  Genre(id: 11, title: "Sobrevivência", color: Colors.indigo),
];

List<Game> myGames = [
  Game(
    id: '1',
    title: 'The Witcher 3',
    imageUrl:
        'https://cdn.awsli.com.br/2500x2500/1610/1610163/produto/177701502/poster-the-witcher-3-d-b3cd5d55.jpg',
    genres: [3, 2, 7],
    releaseDate: DateTime(2015, 5, 19),
    // status: GameStatus.concluded,
    platforms: ['PC', 'PlayStation 4', 'Xbox One', 'Nintendo Switch'],
    synopsis:
        'Uma aventura épica em um mundo de fantasia sombrio. Jogue como Geralt de Rivia, um caçador de monstros em busca de sua filha adotiva em um vasto mundo aberto.',
  ),
  Game(
    id: '2',
    title: 'Cyberpunk 2077',
    imageUrl:
        'https://cdn.cloudflare.steamstatic.com/steam/apps/1091500/header.jpg',
    genres: [3, 7],
    releaseDate: DateTime(2020, 12, 10),
    // status: GameStatus.playing,
    platforms: ['PC', 'PlayStation 5', 'Xbox Series X/S'],
    synopsis:
        'Uma história de ação e aventura ambientada em Night City, uma megalópole obcecada por poder, glamour e modificações corporais.',
  ),
  Game(
    id: '3',
    title: 'God of War',
    imageUrl:
        'https://image.api.playstation.com/vulcan/img/rnd/202010/2217/k1laGX3Ita2N6Jlb7BbkHYAr.png',
    genres: [1, 2],
    releaseDate: DateTime(2018, 4, 20),
    // status: GameStatus.concluded,
    platforms: ['PC', 'PlayStation 4', 'PlayStation 5'],
    synopsis:
        'Kratos, o antigo Deus da Guerra, vive agora nas terras nórdicas com seu filho Atreus. Juntos, enfrentam deuses e monstros em uma jornada emocional.',
  ),
  Game(
    id: '4',
    title: 'Elden Ring',
    imageUrl: 'https://i.redd.it/9jr2a68dx24b1.png',
    genres: [3, 7],
    releaseDate: DateTime(2022, 2, 25),
    // status: GameStatus.playing,
    platforms: [
      'PC',
      'PlayStation 4',
      'PlayStation 5',
      'Xbox One',
      'Xbox Series X/S',
    ],
    synopsis:
        'Um RPG de ação em mundo aberto criado pela FromSoftware e George R.R. Martin. Explore as Terras Intermédias e torne-se o Lorde Prístino.',
  ),
  Game(
    id: '5',
    title: 'Magic: The gathering',
    imageUrl:
        'https://img.odcdn.com.br/wp-content/uploads/2024/12/imagem_2024-12-30_170314856.png',
    genres: [5],
    releaseDate: DateTime(1993, 12, 5),
    // status: GameStatus.retiree,
    platforms: ['PC', 'Mobile'],
    synopsis:
        'O clássico jogo de cartas colecionáveis agora em formato digital. Construa decks, duelar contra outros jogadores e colecione milhares de cartas.',
  ),
  Game(
    id: '6',
    title: 'Hollow Knight',
    imageUrl:
        'https://static0.gamerantimages.com/wordpress/wp-content/uploads/2024/12/mixcollage-07-dec-2024-08-04-am-836.jpg',
    genres: [8, 2],
    releaseDate: DateTime(2017, 2, 24),
    // status: GameStatus.wishPlay,
    platforms: ['PC', 'PlayStation 4', 'Xbox One', 'Nintendo Switch'],
    synopsis:
        'Explore cavernas sinuosas, lute contra criaturas corrompidas e faça amizade com insetos bizarros em um reino arruinado abaixo da cidade de Dirtmouth.',
  ),
  Game(
    id: '7',
    title: 'Red Dead Redemption 2',
    imageUrl:
        'https://upload.wikimedia.org/wikipedia/pt/e/e7/Red_Dead_Redemption_2.png',
    genres: [7, 2],
    releaseDate: DateTime(2018, 10, 26),
    // status: GameStatus.playing,
    platforms: ['PC', 'PlayStation 4', 'Xbox One'],
    synopsis:
        'América, 1899. Arthur Morgan e a gangue Van der Linde são forçados a fugir. Com agentes federais e os melhores caçadores de recompensas em seu encalço.',
  ),
  Game(
    id: '8',
    title: 'Dark Souls III',
    imageUrl:
        'https://cdn.cloudflare.steamstatic.com/steam/apps/374320/header.jpg',
    genres: [3, 1],
    releaseDate: DateTime(2016, 3, 24),
    // status: GameStatus.concluded,
    platforms: ['PC', 'PlayStation 4', 'Xbox One'],
    synopsis:
        'A escuridão retorna ao Reino de Lothric. Um RPG de ação desafiador onde cada morte ensina uma lição. Enfrente chefes épicos e explore um mundo interconectado.',
  ),
  Game(
    id: '9',
    title: 'Resident Evil 4 Remake',
    imageUrl:
        'https://cdn.cloudflare.steamstatic.com/steam/apps/2050650/header.jpg',
    genres: [9, 1, 2],
    releaseDate: DateTime(2023, 3, 24),
    // status: GameStatus.wishPlay,
    platforms: ['PC', 'PlayStation 5', 'Xbox Series X/S'],
    synopsis:
        'O clássico de terror refeitro do zero. Leon S. Kennedy é enviado para resgatar a filha do presidente em uma vila europeia infestada por cultistas.',
  ),
  Game(
    id: '10',
    title: 'Sekiro: Shadows Die Twice',
    imageUrl:
        'https://cdn.cloudflare.steamstatic.com/steam/apps/814380/header.jpg',
    genres: [1, 2],
    releaseDate: DateTime(2019, 3, 22),
    // status: GameStatus.concluded,
    platforms: ['PC', 'PlayStation 4', 'Xbox One'],
    synopsis:
        'Japão feudal, Era Sengoku. Você é o lobo, um shinobi desfigurado e caído em desgraça, resgatado à beira da morte. Vingue-se de seus inimigos.',
  ),
  Game(
    id: '11',
    title: 'DOOM Eternal',
    imageUrl:
        'https://cdn.cloudflare.steamstatic.com/steam/apps/782330/header.jpg',
    genres: [10, 1],
    releaseDate: DateTime(2020, 3, 20),
    // status: GameStatus.playing,
    platforms: [
      'PC',
      'PlayStation 4',
      'PlayStation 5',
      'Xbox One',
      'Xbox Series X/S',
      'Nintendo Switch',
    ],
    synopsis:
        'Os exércitos do Inferno invadiram a Terra. Torne-se o Slayer em uma campanha épica para derrotar demônios através de dimensões e impedir a destruição final.',
  ),
  Game(
    id: '12',
    title: 'Stardew Valley',
    imageUrl:
        'https://cdn.cloudflare.steamstatic.com/steam/apps/413150/header.jpg',
    genres: [6, 11, 2],
    releaseDate: DateTime(2016, 2, 26),
    // status: GameStatus.wishPlay,
    platforms: ['PC', 'PlayStation 4', 'Xbox One', 'Nintendo Switch', 'Mobile'],
    synopsis:
        'Você herdou a velha fazenda de seu avô. Com ferramentas de segunda mão e algumas moedas, comece sua nova vida no campo cultivando, criando animais e fazendo amigos.',
  ),
  Game(
    id: '13',
    title: 'The Legend of Zelda: Breath of the Wild',
    imageUrl:
        'https://assets.nintendo.com/image/upload/ar_16:9,b_auto:border,c_pad,dpr_2.0,f_auto,q_auto,w_1200/v1/ncom/en_US/games/switch/t/the-legend-of-zelda-breath-of-the-wild-switch/hero',
    genres: [2, 7, 3],
    releaseDate: DateTime(2017, 3, 3),
    // status: GameStatus.concluded,
    platforms: ['Nintendo Switch', 'Wii U'],
    synopsis:
        'Entre em um mundo de aventura. Explore e descubra os segredos de Hyrule selvagem nesta aventura de mundo aberto. Link desperta de um sono de 100 anos.',
  ),
  Game(
    id: '14',
    title: "Assassin's Creed Valhalla",
    imageUrl:
        'https://cdn.cloudflare.steamstatic.com/steam/apps/2208920/header.jpg',
    genres: [7, 1, 2],
    releaseDate: DateTime(2020, 11, 10),
    // status: GameStatus.wishPlay,
    platforms: [
      'PC',
      'PlayStation 4',
      'PlayStation 5',
      'Xbox One',
      'Xbox Series X/S',
    ],
    synopsis:
        'Torne-se Eivor, um lendário guerreiro viking. Explore a Inglaterra da Era das Trevas, incursione em terras inimigas e construa um novo lar para seu clã.',
  ),
  Game(
    id: '15',
    title: 'Marvel Rivals',
    imageUrl:
        'https://sm.ign.com/ign_br/cover/m/marvel-riv/marvel-rivals_ypwz.jpg',
    genres: [10, 5],
    releaseDate: DateTime(2024, 12, 2),
    // status: GameStatus.playing,
    platforms: ['PC', 'PlayStation 5', 'Xbox Series X/S'],
    synopsis:
        'Um jogo de tiro em equipe 6v6 baseado em super-heróis da Marvel. Escolha entre diversos heróis e vilões icônicos, cada um com habilidades únicas.',
  ),
  Game(
    id: '16',
    title: 'Hades',
    imageUrl:
        'https://cdn.cloudflare.steamstatic.com/steam/apps/1145360/header.jpg',
    genres: [3, 1],
    releaseDate: DateTime(2020, 9, 17),
    // status: GameStatus.concluded,
    platforms: [
      'PC',
      'PlayStation 4',
      'PlayStation 5',
      'Xbox One',
      'Xbox Series X/S',
      'Nintendo Switch',
    ],
    synopsis:
        'Desafie o deus dos mortos enquanto você luta para sair do Submundo. Zagreus busca escapar, encontrando deuses do Olimpo que concedem poderes.',
  ),
  Game(
    id: '17',
    title: 'Minecraft',
    imageUrl:
        'https://tse4.mm.bing.net/th/id/OIP.Ak_R_TT72TOXYxT6x7auIAHaLH?rs=1&pid=ImgDetMain&o=7&rm=3',
    genres: [11, 6, 2],
    releaseDate: DateTime(2011, 11, 18),
    // status: GameStatus.playing,
    platforms: ['PC', 'PlayStation 4', 'Xbox One', 'Nintendo Switch', 'Mobile'],
    synopsis:
        'Explore mundos gerados aleatoriamente e construa coisas incríveis, desde a mais simples das casas ao maior dos castelos. Jogue no modo criativo ou sobrevivência.',
  ),
];
