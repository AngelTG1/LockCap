import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ApiService {
  final String baseUrl = "http://10.0.2.2:3000/API/v1"; // 👈 Android Emulator

  // 🔑 Login
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final url = Uri.parse("$baseUrl/auth/login");
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
            "Error en login [${response.statusCode}]: ${response.body}");
      }
    } catch (e) {
      throw Exception("❌ Error en la petición: $e");
    }
  }

  // 📌 Crear producto
  Future<Product> createProduct(Product product) async {
    final url = Uri.parse("$baseUrl/products");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(product.toJson()), // 👈 usamos toJson del modelo
    );

    if (response.statusCode == 201) {
      final body = jsonDecode(response.body);
      return Product.fromJson(body["data"]); // 👈 usamos fromJson del modelo
    } else {
      throw Exception(
          "Error creando producto [${response.statusCode}]: ${response.body}");
    }
  }

  // 📌 Obtener lista de productos
  Future<List<Product>> getProducts() async {
    final url = Uri.parse("$baseUrl/products");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final List<dynamic> list = body["data"] ?? [];

      return list.map((p) => Product.fromJson(p)).toList();
    } else {
      throw Exception(
          "Error al traer productos [${response.statusCode}]: ${response.body}");
    }
  }
}
