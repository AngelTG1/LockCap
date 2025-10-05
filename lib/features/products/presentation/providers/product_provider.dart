import 'package:flutter/material.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/get_products.dart';
import '../../domain/usecases/add_product.dart';

class ProductProvider extends ChangeNotifier {
  final GetProducts getProductsUseCase;
  final AddProduct addProductUseCase;

  List<Product> _products = [];
  List<Product> get products => _products;

  ProductProvider(this.getProductsUseCase, this.addProductUseCase);

  // Traer productos
  Future<void> fetchProducts() async {
    _products = await getProductsUseCase();
    notifyListeners();
  }

  // Crear producto
  Future<void> addProduct(Product product) async {
    final newProduct = await addProductUseCase(product);
    _products.add(newProduct);
    notifyListeners();
  }
}
