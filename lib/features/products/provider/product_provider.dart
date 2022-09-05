import 'package:fake_products_app/features/products/data/product_model.dart';
import 'package:fake_products_app/features/products/services/product_service.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  // Private Variable
  List<ProductModel> _products = [];

  // Public variable to access the list of product items
  List<ProductModel> get products => _products;

  fetchProductFromProvider() async {
    var res = await ProductService.fetchProducts();
    _products = res;
    notifyListeners();
  }

  // first post
  String? _accessToken;
  String? get accessToken => _accessToken;

  // Future<String> postLoginCredentials() async {
  //  var res = ProductService.postLoginCredentials
  //  if (res == null) {

  //  } else {
  //   // secure storage
  //   getUserData();
  //  }
  // }

  // Future<PrincipalLoginModel> getUserData() async {
  //   ProductService.getData(_accessToken);
  // }

  // getPostApi
}
