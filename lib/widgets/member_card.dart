import 'package:flutter/material.dart';

class BuildMemberCard extends StatelessWidget{
  const BuildMemberCard({
    super.key,
    required this.name,
    required this.imageUrl,
  });

  final String name;
  final String imageUrl;

  @override
  Widget build(BuildContext context){
    return Card(
      color: const Color.fromRGBO(30, 19, 69, 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        child: ListTile(
          leading: CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(imageUrl),
        ),
        title: Text(
          name,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: const Icon(Icons.videogame_asset, color: Colors.white54),
        ),
      ),
    );
  }
}