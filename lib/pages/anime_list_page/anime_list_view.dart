import 'package:anime_list/core/extensions/context_extension.dart';
import 'package:anime_list/pages/anime_list_page/anime_list_bloc.dart';
import 'package:anime_list/pages/anime_list_page/anime_list_enums.dart';
import 'package:anime_list/pages/anime_list_page/widgets/anime_list_databody.dart';
import 'package:anime_list/pages/anime_list_page/widgets/anime_type_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'native_services.dart';

class AnimeListView extends StatefulWidget {
  const AnimeListView({super.key});

  @override
  State<AnimeListView> createState() => _AnimeListViewState();
}

class _AnimeListViewState extends State<AnimeListView> {
  late AnimeListBloc animeListBloc;

  @override
  void initState() {
    animeListBloc = AnimeListBloc();
    NativeMethodChannel.listenForNativeCalls(animeListBloc);
    animeListBloc.add(FetchAnimeList(1));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => animeListBloc,
      child: BlocBuilder<AnimeListBloc, AnimeListState>(
        builder: (BuildContext context, AnimeListState state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: CheckboxListTile(
                        value: state is AnimeListLoaded
                            ? state.selectedFilter ?? false
                            : false,
                        onChanged: (value) {
                          context
                              .read<AnimeListBloc>()
                              .add(ChangeAnimeFilter(upcoming: value));
                        },
                        title: Text(AnimeFilterEnum.upcoming.description),
                      ),
                    ),
                    context.mediumWidthSizedBox,
                    const AnimeTypeFilter(),
                  ],
                ),
              ),
              context.thinDarkDivider,
              Expanded(child: AnimeListDataBody(state: state))
            ],
          );
        },
      ),
    );
  }
}
