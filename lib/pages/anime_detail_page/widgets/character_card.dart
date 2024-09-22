import 'package:anime_list/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import '../models/character_model.dart';

class CharacterCard extends StatelessWidget {
  final CharacterModel character;
  const CharacterCard({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Column(
        children: [
          ClipOval(
            child: Image.network(
              character.images!,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 4),
          SizedBox(
            width: 100,
            child: Text(
              character.name!,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: context.textTitleSmall,
            ),
          ),
        ],
      ),
    );
  }
}
