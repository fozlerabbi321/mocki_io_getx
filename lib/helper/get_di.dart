import 'package:get/get.dart';
import 'package:mystarter/controler/theme_controller.dart';
import 'package:mystarter/helper/sqlite_db_helper.dart';
import 'package:mystarter/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controler/cart_controller.dart';
import '../controler/products_controller.dart';
import '../services/api/api_client.dart';
import '../services/repository/cart_repo.dart';
import '../services/repository/product_repo.dart';

Future<void> init() async {
  /// Core
  prefs = await SharedPreferences.getInstance();
  //Init Database
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;
  Get.lazyPut(() => prefs,);
  Get.lazyPut(() => _databaseHelper, fenix: true,);
  Get.lazyPut(() => ApiClient(), fenix: true);

  /// theme Controller
  Get.lazyPut(
    () => ThemeController(),
    fenix: true,
  );

  /// Repositories
  Get.lazyPut(() => ProductRepo(apiClient: Get.find(),), fenix: true,);
  Get.lazyPut(() => CartRepo(databaseHelper: Get.find(),), fenix: true,);

  /// sqlite database controllers
  Get.lazyPut(() => CartController(cartRepo: Get.find(), ), fenix: true);
  /// Controllers
  Get.lazyPut(() => ProductsController(productRepo: Get.find(), ), fenix: true);
}
