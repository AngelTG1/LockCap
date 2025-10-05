import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Imports productos
import 'features/products/data/datasources/product_api.dart';
import 'features/products/data/repositories/product_repository_impl.dart';
import 'features/products/domain/usecases/get_products.dart';
import 'features/products/domain/usecases/add_product.dart';
import 'features/products/presentation/providers/product_provider.dart';
import 'features/products/presentation/pages/home_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Inyección de dependencias
    final productApi = ProductApi();
    final productRepository = ProductRepositoryImpl(productApi);
    final getProducts = GetProducts(productRepository);
    final addProduct = AddProduct(productRepository);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductProvider(getProducts, addProduct),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(), 
      ),
    );
  }
}
