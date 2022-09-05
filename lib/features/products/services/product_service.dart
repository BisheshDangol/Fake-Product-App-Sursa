import 'dart:convert';
import 'package:fake_products_app/features/products/data/rating_model.dart';
import 'package:http/http.dart' as http;

import 'package:fake_products_app/features/products/data/product_model.dart';

class ProductService {
  static Future<List<ProductModel>> fetchProducts() async {
    var response =
        await http.get(Uri.parse('http://fakestoreapi.com/products/'));
    var jsonData = json.decode(response.body);

    List<ProductModel> products = [];
    print('hello');
    for (var u in jsonData) {
      ProductModel product = ProductModel(
          id: u["id"] as int,
          title: u["title"],
          price: u["price"],
          description: u["description"],
          category: u["category"],
          image: u["image"],
          rating: RatingModel.fromJson(u["rating"]));

      products.add(product);
    }
    print('${products}');
    return products;
  }

  // static Future<PrincipalLoginModel> getUserData(String accessToken) async {

  // }
}
