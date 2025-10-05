class Product {
  final String name;
  final String category;
  final double price;
  final String? description;
  final String? image;

  Product({
    required this.name,
    required this.category,
    required this.price,
    this.description,
    this.image,
  });
}
