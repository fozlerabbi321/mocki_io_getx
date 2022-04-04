import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:mystarter/services/repository/product_repo.dart';

import '../models/response/rp_products.dart';
import '../services/api/api_checker.dart';

class ProductsController extends GetxController {
  final ProductRepo productRepo;
  ProductsController({required this.productRepo});

  //Init model
  List<Products> _productList = [];
  //Init
  int _sliderIndex = 0;
  bool _isLoading = false;
  bool _isShimmerLoading = true;
  late int _popularPageSize;
  List<String> _offsetList = [];
  int get sliderIndex => _sliderIndex;
  int _offset = 1;

  ///Encapsulation
  List<Products> get productList => _productList;

  bool get isLoading => _isLoading;
  bool get isShimmerLoading => _isShimmerLoading;
  int get popularPageSize => _popularPageSize;
  int get offset => _offset;

  void setOffset(int offset) {
    _offset = offset;
  }

  Future<void> getNotificationList(String offset, bool reload,) async {
    if (offset == '1' || reload) {
      _offsetList = [];
      _offset = 1;

      if (reload) {
        _productList = [];
        _isShimmerLoading = true;
      }
      update();
    }
    if (!_offsetList.contains(offset)) {
      _offsetList.add(offset);
      final response = await productRepo.fetchProducts(offset, perPage: '15',);
      if (response.statusCode == 200) {
        if (offset == '1') {
          _productList = [];
        }
        var posts = RpProductsData.fromJson(jsonDecode(response.body));
        if (posts.products!.isEmpty) {
          _isLoading =  false;
          _isShimmerLoading =  false;
          update();
        } else {
          log('=================>> add log');
          _productList.addAll(posts.products!);
          _popularPageSize = posts.total!;
          _isLoading = false;
          _isShimmerLoading = false;
          update();
        }
      } else {
        ApiChecker.checkApi(response);
      }
    } else {
      if (isLoading) {
        _isLoading = false;
        update();
      }
    }
  }

  void showBottomLoader() {
    _isLoading = true;
    update();
  }

  void showShimmerLoader() {
    _isShimmerLoading = true;
    update();
  }

  void updateSlider(int index) {
    _sliderIndex = index;
    update();
  }
}
