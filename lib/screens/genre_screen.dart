import 'package:flutter/material.dart';
import 'package:avaliacao_mobile_2025/models/genre.dart';
import 'package:avaliacao_mobile_2025/widgets/genre_item.dart';

class GenreScreen extends StatelessWidget {
  const GenreScreen({
    super.key,
    required this.genres,
  });

  final List<Genre> genres;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: genres.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index){
          final genre = genres[index];
          return GenreItem(
              genre: genre,
          );
        }
      );
  }
}