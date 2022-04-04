import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mystarter/constants/images.dart';
import 'package:mystarter/models/response/rp_products.dart';

import '../../../constants/colors_data.dart';
import '../../../constants/size_config.dart';
import '../../../constants/style_data.dart';
import '../../../controler/products_controller.dart';
import '../../widgets/custom_field.dart';
import '../../widgets/custom_image.dart';
import '../../widgets/custom_loader.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../widgets/default_btn.dart';
import 'widgets/product_shimmer.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  Future<void> _loadData(bool reload) async {
    Get.find<ProductsController>().setOffset(1);
    Get.find<ProductsController>().getNotificationList(
      '1',
      reload,
    );
  }

  @override
  Widget build(BuildContext context) {
    _loadData(false);
    final ScrollController scrollController = ScrollController();
    //load getX controller
    //_loadData(false);

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !Get.find<ProductsController>().isLoading) {
        int pageSize = Get.find<ProductsController>().popularPageSize;
        if (Get.find<ProductsController>().productList.length < pageSize) {
          Get.find<ProductsController>()
              .setOffset(Get.find<ProductsController>().offset + 1);
          log('end page');
          Get.find<ProductsController>().showBottomLoader();
          Get.find<ProductsController>().getNotificationList(
            Get.find<ProductsController>().offset.toString(),
            false,
          );
        } else {
          showCustomSnackBar('No more data available');
        }
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: CustomField(
            hintText: 'Search in Swipexyz..'.tr,
            fillColor: const Color(0xFFF4F5F7),
            radius: 12,
            prefixIcon: Icons.search,
          ),
        ),
        elevation: 0.5,
      ),
      body: RefreshIndicator(
        color: kPrimaryColor,
        backgroundColor: Theme.of(context).cardColor,
        displacement: 0,
        onRefresh: () async {
          _loadData(true);
        },
        child: GetBuilder<ProductsController>(
          builder: (productsController) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Container(
                          child: productsController.isShimmerLoading
                              ? const ProductShimmer(
                                  count: 39,
                                )
                              : productsController.productList.isNotEmpty
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 10,
                                      ),
                                      child: SingleChildScrollView(
                                        controller: scrollController,
                                        child: MasonryGridView.count(
                                          shrinkWrap: true,
                                          padding: EdgeInsets.zero,
                                          crossAxisCount: 3,
                                          scrollDirection: Axis.vertical,
                                          itemCount: productsController
                                              .productList.length,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          mainAxisSpacing: 6.0,
                                          crossAxisSpacing: 6.0,
                                          itemBuilder: (context, int index) {
                                            return InkWell(
                                              onTap: () {
                                                productPopup(
                                                  context,
                                                  productsController
                                                      .productList[index],
                                                  productsController,
                                                );
                                              },
                                              child: CustomImage(
                                                image: productsController
                                                    .productList[index]
                                                    .thumbnail,
                                                radius: 15,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    )
                                  : Center(
                                      child: Text(
                                        'No data available',
                                        style: kRegularText2,
                                      ),
                                    ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: CustomBottomLoader(
                              isLoading: productsController.isLoading),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  productPopup(BuildContext context, Products products,
      ProductsController productsController) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          backgroundColor: Theme.of(context).backgroundColor,
          content: SizedBox(
            width: SizeConfig.screenWidth,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    CustomImage(
                      width: 35,
                      height: 35,
                      radius: 8,
                      image: products.thumbnail,
                    ),
                    kWidthBox10,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            products.title ?? '',
                            maxLines: 1,
                            style: kRegularText2.copyWith(
                              fontWeight: FontWeight.w700,
                              color: Get.isDarkMode
                                  ? kWhiteColor
                                  : const Color(0xFF172B4D),
                            ),
                          ),
                          Text(
                            products.brand ?? '',
                            maxLines: 1,
                            style: kSmallText.copyWith(
                              fontWeight: FontWeight.w400,
                              color: Get.isDarkMode
                                  ? kWhiteColor
                                  : const Color(0xFF172B4D),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        decoration: BoxDecoration(
                          color: kPrimaryColor.withOpacity(.05),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              Images.addFriend,
                            ),
                            kWidthBox5,
                            Text(
                              'Follow'.tr,
                              style: kDescriptionText.copyWith(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                kHeightBox15,
                Stack(
                  fit: StackFit.loose,
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                          aspectRatio: 1,
                          viewportFraction: 1,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 5),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 1000),
                          autoPlayCurve: Curves.easeInCubic,
                          enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
                          onPageChanged: (int sliderIndex, reason) {
                            productsController.updateSlider(sliderIndex);
                          }),
                      items: products.images!
                          .map(
                            (item) => CustomImage(
                              image: item,
                              radius: 15,
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
                kHeightBox15,
                SizedBox(
                  width: SizeConfig.screenWidth,
                  child: DefaultBtn(
                    onPress: () {
                      Get.back();
                    },
                    title: 'View Post'.tr,
                    textStyle: kRegularText2.copyWith(
                      color: Get.isDarkMode ? kWhiteColor : kSecondaryColor,
                      fontWeight: FontWeight.w700,
                    ),
                    radius: 15,
                    height: 44,
                    btnColor: const Color(0XFFF4F5F7),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
