import 'package:anime_list/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class NeumorphicContainer extends StatelessWidget {
  const NeumorphicContainer({super.key, required this.child});
  final Widget child;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.mediaQuery.size.width,
      padding: context.paddingMedium,
      margin: context.paddingLow,
      decoration: BoxDecoration(
        boxShadow: [
          neumorphicShadow(-6.0),
          neumorphicShadow(6.0)
        ],
        color: Colors.white,
        borderRadius: context.borderRadiusSemiCirc,
      ),
      child: child,
    );
  }
}

BoxShadow neumorphicShadow(double offset){
  return  BoxShadow(
    color: Colors.black.withOpacity(0.1),
    offset: Offset(offset, offset),
    blurRadius: 16.0,
  );
}