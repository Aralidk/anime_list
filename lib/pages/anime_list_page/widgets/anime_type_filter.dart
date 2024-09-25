import 'package:anime_list/core/extensions/context_extension.dart';
import 'package:anime_list/pages/anime_list_page/bloc/anime_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../anime_list_enums.dart';
import '../bloc/list_events.dart';
import '../bloc/list_states.dart';

class AnimeTypeFilter extends StatelessWidget {
  const AnimeTypeFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnimeListBloc, AnimeListState>(
      builder: (context, state) {
        return PopupMenuButton(
          constraints: const BoxConstraints(maxHeight: 400, minWidth: 100),
          itemBuilder: (BuildContext context) {
            return List.generate(
              2,
              (index) => PopupMenuItem(
                child: Center(
                  child: Text(AnimeFilterEnum.values[index].description),
                ),
                onTap: () {
                  context.read<AnimeListBloc>().add(
                        ChangeAnimeFilter(
                            type: AnimeFilterEnum.values[index].description),
                      );
                },
              ),
            );
          },
          child: Container(
            padding: context.paddingLow,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: context.boxBorder,
            ),
            height: 57,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(state is AnimeListLoaded
                    ? state.type ?? "Choose a Type"
                    : "Choose a Type"),
                context.lowWidthSizedBox,
                const Icon(Icons.filter_list_alt),
              ],
            ),
          ),
        );
      },
    );
  }
}
