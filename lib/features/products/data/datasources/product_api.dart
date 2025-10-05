import 'dart:convert';
import '../../../../core/network/http_client.dart';
import '../../../../core/network/api_config.dart';
import '../models/product_model.dart';

class ProductApi {
  final httpClient = HttpClient().client;

  Future<List<ProductModel>> getProducts() async {
    final baseUrl = await ApiConfig.getBaseUrl();
    final response = await httpClient.get(Uri.parse("$baseUrl/products"));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final List<dynamic> list = body["data"];
      return list.map((p) => ProductModel.fromJson(p)).toList();
    } else {
      throw Exception("Error al traer productos: ${response.body}");
    }
  }

  Future<ProductModel> createProduct(ProductModel product) async {
    final baseUrl = await ApiConfig.getBaseUrl();
    final response = await httpClient.post(
      Uri.parse("$baseUrl/products"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(product.toJson()),
    );

    if (response.statusCode == 201) {
      final body = jsonDecode(response.body);
      return ProductModel.fromJson(body["data"]);
    } else {
      throw Exception("Error creando producto: ${response.body}");
    }
  }
}
