import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomSvgPicture extends StatelessWidget {
  const CustomSvgPicture({super.key, required this.path, this.withColor = true, this.width, this.height});
  const CustomSvgPicture.withoutColor({super.key, required this.path, this.width, this.height}) : withColor = false;
  final String path;
  final bool withColor;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      width: width,
      height: height,
      colorFilter: withColor ? ColorFilter.mode(Theme.of(context).colorScheme.secondary, BlendMode.srcIn) : null,
    );
  }
}
