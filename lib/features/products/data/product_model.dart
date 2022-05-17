import 'package:fake_products_app/features/products/data/rating_model.dart';

class ProductModel {
  final int id;
  final String title;
  final dynamic price;
  final String description;
  final String category;
  final String image;
  final RatingModel rating;

  const ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        id: json['id'],
        title: json['title'],
        category: json['category'],
        description: json['description'],
        price: json['price'],
        image: json['image'],
        rating: json['rating']);
  }
}
