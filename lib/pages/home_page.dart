import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screen_protector/screen_protector.dart'; // 👈 para bloquear capturas
import '../components/card_item.dart';
import '../provider/add_provider.dart';
import 'add_product_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _disableScreenshot(); // Bloquea capturas al entrar
  }

  @override
  void dispose() {
    _enableScreenshot(); // Libera bloqueo al salir
    super.dispose();
  }

  Future<void> _disableScreenshot() async {
    await ScreenProtector.preventScreenshotOn();
  }

  Future<void> _enableScreenshot() async {
    await ScreenProtector.preventScreenshotOff();
  }

  @override
  Widget build(BuildContext context) {
    final products = context.watch<ProductProvider>().products;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {},
        ),
        title: const Text(
          "Furnituristic",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Badge(
              child: IconButton(
                icon: const Icon(Icons.shopping_cart_outlined),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search type..",
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.tune),
                    onPressed: () {},
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
            ),

            // 📌 Categorías
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("All",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.w600)),
                SizedBox(width: 20),
                Text("Chair",
                    style: TextStyle(fontSize: 16, color: Colors.blueGrey)),
                SizedBox(width: 20),
                Text("Sofa",
                    style: TextStyle(fontSize: 16, color: Colors.blueGrey)),
                SizedBox(width: 20),
                Text("Table",
                    style: TextStyle(fontSize: 16, color: Colors.blueGrey)),
              ],
            ),

            const SizedBox(height: 20),

            // 📌 Imagen de oferta
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Image.asset(
                'assets/images/oferta.png',
                height: 200,
                fit: BoxFit.contain,
              ),
            ),

            const SizedBox(height: 20),

            // 📌 Productos dinámicos
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: products.isEmpty
                  ? const Text("No hay productos aún, agrega uno con ➕")
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 0.6,
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return CardItem(
                          category: product.category,
                          title: product.title,
                          image: product.image,
                          rating: product.rating,
                          reviews: product.reviews,
                          price: product.price,
                        );
                      },
                    ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddProductPage()),
          );
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
