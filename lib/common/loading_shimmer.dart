import 'package:anime_list/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../core/constants/colors.dart';

class KrakenLoadingShimmer extends StatelessWidget {
  const KrakenLoadingShimmer({super.key, required this.title, this.width});
  final String title;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: krakenRed,
      highlightColor: krakenDarkRed,
      child: Container(
        height: 30,
        width: width ?? context.mediaQuery.size.width,
        alignment: Alignment.center,
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            border: Border.all(width: 2),
            borderRadius: context.borderRadiusCirc),
        child: Text(title, style: TextStyle(color: krakenDarkRed, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
