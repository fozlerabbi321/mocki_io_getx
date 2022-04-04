import 'package:http/http.dart';
import 'package:mystarter/services/api/api_client.dart';

import '../api/app_config.dart';

class ProductRepo {
  final ApiClient apiClient;

  ProductRepo({
    required this.apiClient,
  });

  Future<Response> fetchProducts(String offset,
  {String perPage = '15',}) async {
    var url = productList;

    return await apiClient.getData(url + '?page=$offset&limit=$perPage');
  }
}
