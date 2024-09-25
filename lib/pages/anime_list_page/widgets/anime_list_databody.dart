import 'package:anime_list/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../common/loading_shimmer.dart';
import '../../../common/neumorphic_container.dart';
import '../../anime_detail_page/anime_detail_view.dart';
import '../bloc/anime_list_bloc.dart';
import '../bloc/list_events.dart';
import '../bloc/list_states.dart';

class AnimeListDataBody extends StatelessWidget {
  const AnimeListDataBody({super.key, required this.state});
  final AnimeListState state;

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        context.read<AnimeListBloc>().add(
              FetchAnimeList(
                context.read<AnimeListBloc>().currentPage + 1,
                filter: context.read<AnimeListBloc>().isUpcomingFilter
                    ? "Upcoming"
                    : null,
                type: context.read<AnimeListBloc>().currentType,
              ),
            );
      }
    });

    if (state is AnimeListLoading) {
      return const KrakenLoadingShimmer(title: "Loading");
    } else if (state is AnimeListLoaded) {
      final animeList = (state as AnimeListLoaded).animeList;
      return ListView.builder(
        itemCount: animeList.length,
        controller: scrollController,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return AnimeDetailView(
                        animeId: animeList[index].id!,
                        animeName: animeList[index].title!);
                  },
                ),
              );
            },
            child: NeumorphicContainer(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  animeList[index].imageUrl == null
                      ? Image.asset('assets/placeholder.png')
                      : Image.network(animeList[index].imageUrl!,
                          errorBuilder: (context, error, stackTrace) {
                          return Image.asset('assets/placeholder.png');
                        }, width: 150, height: 200, fit: BoxFit.cover),
                  context.mediumWidthSizedBox,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          animeList[index].title!,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                        context.mediumHeightSizedBox,
                        Row(
                          children: [
                            const Icon(Icons.star),
                            context.lowWidthSizedBox,
                            Text(animeList[index].score.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16)),
                          ],
                        ),
                      ],
                    ),
                  ), // Assuming rating exists in AnimeListModel
                ],
              ),
            ),
          );
        },
      );
    } else {
      return const Center(child: Text("Error Occurred"));
    }
  }
}
