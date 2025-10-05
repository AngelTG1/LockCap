import '../../domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    required String name,
    required String category,
    required double price,
    String? description,
    String? image,
  }) : super(
         name: name,
         category: category,
         price: price,
         description: description,
         image: image,
       );

  // 📥 Convertir JSON → ProductModel
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      name: json["name"] ?? "Sin nombre",
      category: json["category"] ?? "Sin categoría",
      price: _parsePrice(json["price"]),
      description: json["description"],
      image: json["image"] ?? "assets/images/chair.png",
    );
  }

  // 🔑 helper para convertir price sin importar si viene como int, double o String
  static double _parsePrice(dynamic price) {
    if (price is int) {
      return price.toDouble();
    } else if (price is double) {
      return price;
    } else if (price is String) {
      return double.tryParse(price) ?? 0.0;
    } else {
      return 0.0;
    }
  }

  // Convertir ProductModel → JSON
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "price": price,
      "category": category,
      "description": description ?? "Pendiente",
    };
  }
}
