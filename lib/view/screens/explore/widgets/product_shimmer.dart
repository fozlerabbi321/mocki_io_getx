import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';

class ProductShimmer extends StatelessWidget {
  final int count;

  const ProductShimmer({
    Key? key,
    this.count = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: MasonryGridView.count(
        crossAxisCount: 3,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: count,
        physics: const ScrollPhysics(),
        mainAxisSpacing: 6.0,
        crossAxisSpacing: 6.0,
        itemBuilder: (BuildContext context, int index) {
          return AspectRatio(
            aspectRatio: 1,
            child: SizedBox(
              height: 100,
              width: double.infinity,
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  width: double.infinity,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
