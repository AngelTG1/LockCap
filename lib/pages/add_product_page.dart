import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../provider/add_provider.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Agregar Producto")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: "Título"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Ingresa un título" : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _categoryController,
                decoration: const InputDecoration(labelText: "Categoría"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Ingresa una categoría" : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: "Precio"),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return "Ingresa un precio";
                  if (double.tryParse(value) == null) return "Precio inválido";
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _imageController,
                decoration: const InputDecoration(labelText: "Imagen (asset o url)"),
              ),
              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final product = Product(
                      title: _titleController.text,
                      category: _categoryController.text,
                      price: double.parse(_priceController.text),
                      image: _imageController.text.isEmpty
                          ? "assets/images/chair.png"
                          : _imageController.text,
                    );

                    Provider.of<ProductProvider>(context, listen: false)
                        .addProduct(product);

                    Navigator.pop(context); // Regresa a Home
                  }
                },
                child: const Text("Guardar"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
