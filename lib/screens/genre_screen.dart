import 'package:flutter/material.dart';

import 'package:avaliacao_mobile_2025/data/dummy_data.dart';
import 'package:avaliacao_mobile_2025/widgets/genre_item.dart';

class GenreScreen extends StatelessWidget {
  const GenreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gêneros"),
      ),
      body: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
        ),
        children: [
          for (final genre in genres)
            GenreItem(genre: genre),
        ]
      ),
    );
  }
}