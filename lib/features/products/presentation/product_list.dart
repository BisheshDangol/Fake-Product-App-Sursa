import 'dart:convert';

import 'package:fake_products_app/features/products/data/endpoint.dart';
import 'package:fake_products_app/features/products/data/product_model.dart';
import 'package:fake_products_app/features/products/data/rating_model.dart';
import 'package:fake_products_app/features/products/presentation/product_detail_page.dart';
import 'package:fake_products_app/features/products/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  void initState() {
    callProvider();
    super.initState();
  }

  callProvider() async {
    await Provider.of<ProductProvider>(context, listen: false)
        .fetchProductFromProvider();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Products'),
          centerTitle: true,
        ),
        body: Consumer<ProductProvider>(builder: ((context, provider, child) {
          if (provider.products.isEmpty) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Container(
              child: ListView.builder(
                itemCount: provider.products.length,
                itemBuilder: (context, index) => Container(
                    child: Text(provider.products[index].title.toString())),
              ),
            );
          }
        })));
  }
}
