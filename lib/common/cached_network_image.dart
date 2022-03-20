import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';

class NxNetworkImage extends StatelessWidget {
  const NxNetworkImage({
    Key? key,
    required this.imageUrl,
    this.radius,
    this.width,
    this.height,
    this.maxWidth,
    this.maxHeight,
  }) : super(key: key);

  final String imageUrl;
  final double? radius;
  final double? width;
  final double? height;
  final double? maxWidth;
  final double? maxHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height,
      constraints: BoxConstraints(
        maxWidth: maxWidth ?? Dimens.screenWidth,
        maxHeight: maxHeight ?? Dimens.screenHeight,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius ?? 0.0),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          placeholder: (ctx, url) => const SizedBox(
            child: Center(
              child: CupertinoActivityIndicator(),
            ),
          ),
          errorWidget: (ctx, url, err) => const Icon(
            CupertinoIcons.info,
            color: ColorValues.errorColor,
          ),
        ),
      ),
    );
  }
}