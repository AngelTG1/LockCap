class Product {
  final String category;
  final String title;
  final String image;
  final double rating;
  final int reviews;
  final double price;

  Product({
    required this.category,
    required this.title,
    required this.image,
    this.rating = 0.0,
    this.reviews = 0,
    required this.price,
  });

  // 🔎 Convertir JSON → Product
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      category: json["category"] ?? "Unknown",
      title: json["name"] ?? "No title", // backend usa "name"
      image: "assets/images/chair.png",  // temporal, si tu API manda imagen, aquí la cambias
      price: _toDouble(json["price"]),
      rating: _toDouble(json["rating"]),
      reviews: _toInt(json["reviews"]),
    );
  }

  // 🔎 Convertir Product → JSON (para mandar al backend)
  Map<String, dynamic> toJson() {
    return {
      "name": title, // backend espera "name"
      "price": price,
      "category": category,
      "description": "Pendiente", // opcional
    };
  }

  // Helpers para conversión segura
  static double _toDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  static int _toInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? 0;
    if (value is double) return value.toInt();
    return 0;
  }
}
