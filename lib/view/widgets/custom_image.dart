import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../constants/colors_data.dart';
import '../../constants/images.dart';

class CustomImage extends StatelessWidget {
  final double? width;
  final double? height;
  final String? image;
  final String? baseUrl;
  final String? placeHolder;
  final BoxFit? fit;
  final double radius;
  final bool innerShadow;

  const CustomImage({
    Key? key,
    this.width,
    this.height,
    this.placeHolder,
    this.fit,
    this.baseUrl,
    this.radius = 0,
    this.innerShadow = false,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: image != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(radius),
              child: CachedNetworkImage(
                // imageUrl: baseUrl ?? kImageUrl + image,
                imageUrl: image!,
                fit: fit ?? BoxFit.cover,
                color: innerShadow ? Colors.black.withOpacity(.3) : null,
                colorBlendMode: innerShadow ? BlendMode.darken : null,
                placeholder: (context, url) => Container(
                  decoration: BoxDecoration(
                    color: kOrdinaryColor2,
                    borderRadius: BorderRadius.circular(radius),
                  ),
                  child: Image.asset(
                    placeHolder ?? Images.placeHolder,
                    fit: BoxFit.fill,
                  ),
                ),
                errorWidget: (context, url, error) => Image.asset(
                  placeHolder ?? Images.placeHolder,
                  fit: BoxFit.fill,
                ),
              ),
            )
          : Container(
              decoration: BoxDecoration(
                color: kOrdinaryColor2,
                borderRadius: BorderRadius.circular(radius),
              ),
              //height: getProportionateScreenWidth(95),
              //  width: getProportionateScreenWidth(95),
              child: Image.asset(
                placeHolder ?? Images.placeHolder,
                fit: BoxFit.fill,
              ),
            ),
    );
  }
}
