import 'package:anime_list/common/loading_shimmer.dart';
import 'package:anime_list/core/extensions/context_extension.dart';
import 'package:anime_list/pages/anime_detail_page/anime_detail_bloc.dart';
import 'package:anime_list/pages/anime_detail_page/widgets/character_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnimeDetailView extends StatelessWidget {
  const AnimeDetailView(
      {super.key, required this.animeId, required this.animeName});
  final int animeId;
  final String animeName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(animeName)),
      body: BlocProvider(
        create: (context) => AnimeDetailBloc()..add(FetchAnimeDetail(animeId)),
        child: BlocBuilder<AnimeDetailBloc, AnimeDetailState>(
          builder: (BuildContext context, AnimeDetailState state) {
            if (state is AnimeDetailLoading) {
              return const Center(
                  child: KrakenLoadingShimmer(title: "Loading"));
            } else if (state is AnimeDetailLoaded) {
              final animeDetail = state.animeDetail;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Image.network(
                      animeDetail.imageUrl!,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset('assets/placeholder.png');
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            animeDetail.title!,
                            style: context.textTitleLarge,
                          ),
                          Wrap(
                              children: List.generate(
                                  animeDetail.genres?.length ?? 0,
                                  (index) => Chip(
                                      label:
                                          Text(animeDetail.genres![index])))),
                          context.mediumHeightSizedBox,
                          ListTile(
                            shape: context.roundedRectangle,
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Rating: ${animeDetail.score}",
                                ),
                                Text(
                                  "Episodes: ${animeDetail.episodes.toString()}",
                                ),
                              ],
                            ),
                          ),
                          context.mediumHeightSizedBox,
                          Text("Synopsis:", style: context.textTitleMedium),
                          Text(animeDetail.synopsis!),
                          context.mediumHeightSizedBox,
                          Text("Characters:", style: context.textTitleMedium),
                          const SizedBox(height: 8),
                          SizedBox(
                            height: 150,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.characters.length,
                              itemBuilder: (context, index) {
                                return CharacterCard(
                                    character: state.characters[index]);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(child: Text("Error Occured"));
            }
          },
        ),
      ),
    );
  }
}
