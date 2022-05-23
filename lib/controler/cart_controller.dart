import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:mystarter/models/response/rp_products.dart';
import 'package:mystarter/services/repository/cart_repo.dart';

import '../constants/style_data.dart';
import '../models/response/cart_model.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;

  CartController({required this.cartRepo,});

  //Init model
  final List<CartModel> _cartList = [];
  late List<bool> _tempList;

  //Init
  bool _isLoading = false;
  int _totalPrice = 0;
  int _totalQuantity = 0;


  ///Encapsulation
  List<CartModel> get cartList => _cartList;

  List<bool> get tempList => _tempList;

  bool get isLoading => _isLoading;

  int get totalPrice => _totalPrice;

  int get totalQuantity => _totalQuantity;


  ///cart add
  void addToCart(Products product, {
    required int quantity,
    required int price,
    required int stockQty,
    String? size,
    String? color,
    int? productVariantId,
  }) async {
    var productData = await cartRepo.getAllCartList();
    _cartList.assignAll(productData);
    //for adding existing items to the cart and increase quantity
    log('cart Length : ${cartList.length}');
    var contain = _cartList.where((element) => element.id == product.id);
    if (contain.isEmpty) {
      //value not exists
      log('cart value not exists ${product.id ?? 0}');

      String data = json.encode(product);

      ///added new cart item
      //add model
      CartModel rpShopFavoriteModel = CartModel(
        id: product.id ?? 0,
        quantity: quantity,
        price: price,
        image: product.thumbnail,
        title: product.title ?? '',
        brand: product.brand ?? 'No Brand',
        size: size,
        color: color,
        productVariantId: productVariantId,
        barcode: "test",
        stockQty: stockQty,
        products: data,
      );
      cartRepo.insertCart(rpShopFavoriteModel);

      var result = await cartRepo.getAllCartList();
      if (result.isNotEmpty) {
        _cartList.assignAll(result);
        getAllCartList();
      }
      showCustomSnackBar('Added to cart Successfully!', isError: false);
    } else {
      //value exists
      log('cart value exists ${product.id ?? 0}');

      ///update cart
      for (int i = 0; i < _cartList.length; i++) {
        if (_cartList[i].id == product.id!) {
          int qty = (_cartList[i].quantity ?? 0) + 1;
          log(qty.toString() + 'Quantity');
          updateCart(
            product.id ?? 0,
            qty,
          );
          showCustomSnackBar('Update from cart Successfully!', isError: false);
        }
      }
    }
  }

  ///cart remove from item
  Future<void> removeFromCart(int id) async {
    try {
      _isLoading = true;
      await cartRepo.deleteCart(id);
      showCustomSnackBar(
        'Delete from cart Successfully!',
      );
      getAllCartList();
    } finally {
      _isLoading = false;
      update();
    }
  }

  ///Get  all cart
  void getAllCartList({
    bool isTamUp = false,
  }) async {
    try {
      _isLoading = true;
      var product = await cartRepo.getAllCartList();
      _cartList.assignAll(product);
      totalPriceSum();
    } finally {
      _isLoading = false;
      update();
    }
  }

  void updateCart(int id,
      int qty,) async {
    try {
      _isLoading = true;
      log(qty.toString() + 'Quantity check');
      await cartRepo.updateCart(
        id,
        qty,
      );
      getAllCartList();
    } finally {
      _isLoading = false;
      update();
    }
  }

  ///Check already added
  bool isAlreadyAdd(int id) {
    var isExist = _cartList.indexWhere((element) => element.id == id);
    log('Exist : $isExist');
    if (isExist >= 0) {
      return true;
    } else {
      return false;
    }
  }

  void totalPriceSum() async {
    try {
      _isLoading = true;
      _totalPrice = 0;
      _totalQuantity = 0;
      for (int i = 0; i < _cartList.length; i++) {
        _totalPrice = ((cartList[i].price ?? 0) * (cartList[i].quantity ?? 0)) +
            _totalPrice;
        _totalQuantity = (cartList[i].quantity ?? 0) + _totalQuantity;

        log(_totalPrice.toString() + 'total price');
        log(_totalQuantity.toString() + 'total quantity');
        update();
      }
    } finally {
      _isLoading = false;
      update();
    }
  }

  int cartItemQuantity(int id) {
    int quantity = 0;
    for (int i = 0; i < _cartList.length; i++) {
      if (cartList[i].id == id) {
        log(cartList[i].quantity.toString() + 'Quantity');
        quantity = cartList[i].quantity ?? 0;
      }
    }
    return quantity;
  }

  void emptyCart() async {
    try {
      _isLoading = false;
      await cartRepo.emptyShopCart();
      getAllCartList(isTamUp: false);
    } finally {
      _isLoading = false;
      update();
    }
  }
}
