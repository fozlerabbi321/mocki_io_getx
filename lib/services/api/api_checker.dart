import 'dart:convert';
import 'package:mystarter/constants/style_data.dart';
import 'package:http/http.dart';

class ApiChecker {
  static void checkApi(Response response) {
    if (response.statusCode == 401) {
      /* Get.find<AuthController>().clearSharedData();
      Get.find<WishListController>().removeWishes();
      Get.offAllNamed(RouteHelper.getSignInRoute(RouteHelper.splash));*/
    } else {
      final responseJson = jsonDecode(response.body);
      showCustomSnackBar(responseJson['message']);
    }
  }
}
