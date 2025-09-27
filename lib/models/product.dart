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
}
