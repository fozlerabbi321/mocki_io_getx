import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/colors_data.dart';
import '../../../constants/size_config.dart';
import '../../../constants/strings.dart';
import '../../../constants/style_data.dart';
import '../../../controler/cart_controller.dart';
import '../../widgets/custom_alert_dialog.dart';
import '../../widgets/custom_image.dart';
import '../../widgets/default_btn.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({
    Key? key,
  }) : super(key: key);

  Future<void> _loadData(bool reload) async {
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      Get.find<CartController>().getAllCartList(isTamUp: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    _loadData(false);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Shopping'.tr,
        ),
      ),
      body: GetBuilder<CartController>(
        builder: (cartController) {
          return Container(
            child: cartController.cartList.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.remove_shopping_cart,
                          size: getProportionateScreenHeight(50),
                        ),
                        kHeightBox20,
                        Text(
                          'Empty Cart'.tr,
                          style: TextStyle(
                            fontSize: getProportionateScreenHeight(30),
                          ),
                        ),
                      ],
                    ),
                  )
                : Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: cartController.cartList.length,
                              padding: const EdgeInsets.only(top: 10),
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, int index) {
                                log(jsonEncode(cartController.cartList[index]));
                                return Container(
                                  margin: const EdgeInsets.only(
                                    bottom: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).cardColor,
                                    borderRadius: BorderRadius.circular(5.0),
                                    boxShadow: [
                                      kOrdinaryShadow,
                                    ],
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {

                                            },
                                            child: CustomImage(
                                              height:
                                                  getProportionateScreenWidth(
                                                      80),
                                              image: cartController
                                                  .cartList[index].image,
                                              fit: BoxFit.fitHeight,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  cartController.cartList[index]
                                                          .title ??
                                                      '',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline2,
                                                ),
                                                kHeightBox10,
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Theme.of(
                                                                  context)
                                                              .backgroundColor,
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(
                                                            Radius.circular(5),
                                                          ),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: const Color(
                                                                      0xFF000000)
                                                                  .withOpacity(
                                                                      .10),
                                                              blurRadius: 4,
                                                              spreadRadius: 0,
                                                              offset:
                                                                  const Offset(
                                                                      0, 2),
                                                            ),
                                                          ],
                                                        ),
                                                        child: Text(
                                                          '${cartController
                                                              .cartList[
                                                          index]
                                                              .id ?? 0 }',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: kSmallText
                                                              .copyWith(
                                                            color: Get
                                                                    .isDarkMode
                                                                ? kWhiteColor
                                                                : kBlackColor2,
                                                            fontSize: 10.0,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                          ),
                                                        )),
                                                    Row(
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            if ((cartController
                                                                        .cartList[
                                                                            index]
                                                                        .quantity ??
                                                                    0) >
                                                                1) {
                                                              int qty = (cartController
                                                                          .cartList[
                                                                              index]
                                                                          .quantity ??
                                                                      0) -
                                                                  1;
                                                              Get.find<
                                                                      CartController>()
                                                                  .updateCart(
                                                                      cartController
                                                                          .cartList[
                                                                              index]
                                                                          .id!,
                                                                      qty);
                                                            } else {
                                                              deleteCartItem(
                                                                  cartController
                                                                      .cartList[
                                                                          index]
                                                                      .id!,
                                                                  context);
                                                            }
                                                          },
                                                          child: Container(
                                                            width: 25,
                                                            height: 25,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Theme.of(
                                                                      context)
                                                                  .backgroundColor,
                                                              borderRadius:
                                                                  const BorderRadius
                                                                          .all(
                                                                      Radius.circular(
                                                                          3)),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: const Color(
                                                                          0xFF000000)
                                                                      .withOpacity(
                                                                          .10),
                                                                  blurRadius: 4,
                                                                  spreadRadius:
                                                                      0,
                                                                  offset:
                                                                      const Offset(
                                                                          0, 2),
                                                                ),
                                                              ],
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                '-',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: kSmallText
                                                                    .copyWith(
                                                                  color: Get
                                                                          .isDarkMode
                                                                      ? kWhiteColor
                                                                      : kBlackColor2,
                                                                  fontSize:
                                                                      16.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                  height: 1.0,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        kWidthBox15,
                                                        Text(
                                                          '${cartController.cartList[index].quantity ?? 0}',
                                                          maxLines: 1,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .headline1,
                                                        ),
                                                        kWidthBox15,
                                                        InkWell(
                                                          onTap: () {
                                                            log('stock qty: ${cartController.cartList[index].stockQty ?? 0}');
                                                            if ((cartController
                                                                        .cartList[
                                                                            index]
                                                                        .quantity ??
                                                                    0) <
                                                                (cartController
                                                                        .cartList[
                                                                            index]
                                                                        .stockQty ??
                                                                    0)) {
                                                              int qty = (cartController
                                                                          .cartList[
                                                                              index]
                                                                          .quantity ??
                                                                      0) +
                                                                  1;
                                                              Get.find<
                                                                      CartController>()
                                                                  .updateCart(
                                                                      cartController
                                                                          .cartList[
                                                                              index]
                                                                          .id!,
                                                                      qty);
                                                            } else {
                                                              showCustomSnackBar(
                                                                'No more stock!'
                                                                    .tr,
                                                              );
                                                            }
                                                          },
                                                          child: Container(
                                                              width: 25,
                                                              height: 25,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Theme.of(
                                                                        context)
                                                                    .backgroundColor,
                                                                borderRadius:
                                                                    const BorderRadius
                                                                            .all(
                                                                        Radius.circular(
                                                                            3)),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: const Color(
                                                                            0xFF000000)
                                                                        .withOpacity(
                                                                            .10),
                                                                    blurRadius:
                                                                        4,
                                                                    spreadRadius:
                                                                        0,
                                                                    offset:
                                                                        const Offset(
                                                                            0,
                                                                            2),
                                                                  ),
                                                                ],
                                                              ),
                                                              child: Center(
                                                                child: Text(
                                                                  '+',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: kSmallText
                                                                      .copyWith(
                                                                    color: Get
                                                                            .isDarkMode
                                                                        ? kWhiteColor
                                                                        : kBlackColor2,
                                                                    fontSize:
                                                                        16.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w300,
                                                                    height: 1.0,
                                                                  ),
                                                                ),
                                                              )),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                kHeightBox10,
                                                Text(
                                                  kCurrency +
                                                      (cartController
                                                                  .cartList[
                                                                      index]
                                                                  .price ??
                                                              0)
                                                          .toString(),
                                                  style: kRegularText.copyWith(
                                                    color: kPrimaryColor,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      Card(
                        color: Theme.of(context).cardColor,
                        margin: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Text(
                                    'Total'.tr,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1!
                                        .copyWith(
                                          fontWeight: FontWeight.w700,
                                          height: 1.0,
                                          fontSize: 16,
                                        ),
                                  ),
                                ),
                              ),
                              Text(
                                kCurrency +
                                    cartController.totalPrice.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(
                                      fontWeight: FontWeight.w700,
                                      height: 1.0,
                                      fontSize: 16,
                                    ),
                              ),
                              kWidthBox10,
                              DefaultBtn(
                                radius: 5.0,
                                title: 'Check Out'.tr,
                                onPress: () {
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }

  Future deleteCartItem(int id, BuildContext context) {
    return CustomAlertDialog().customAlert2(
      context: context,
      title: 'Delete',
      body: 'Are you sure want to delete?',
      color: kPrimaryColor,
      confirmTitle: 'Delete',
      onPress: () {
        Get.find<CartController>().removeFromCart(id);
        Navigator.pop(context);
      },
    );
  }
}
