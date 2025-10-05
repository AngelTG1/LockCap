// add_product.dart
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class AddProduct {
  final ProductRepository repository;

  AddProduct(this.repository);

  Future<Product> call(Product product) async =>
      await repository.createProduct(product);
}
