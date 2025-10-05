import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_api.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductApi api;

  ProductRepositoryImpl(this.api);

  @override
  Future<List<Product>> getProducts() async {
    // Api regresa ProductModel, que ya hereda de Product
    final products = await api.getProducts();
    return products; // ✅ funciona porque ProductModel es un Product
  }

  @override
  Future<Product> createProduct(Product product) async {
    // Convertir entidad a modelo
    final productModel = ProductModel(
      name: product.name,
      category: product.category,
      price: product.price,
      description: product.description,
      image: product.image,
    );

    final newProduct = await api.createProduct(productModel);
    return newProduct; 
  }
}
