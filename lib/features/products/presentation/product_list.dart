import 'dart:convert';

import 'package:fake_products_app/features/products/data/endpoint.dart';
import 'package:fake_products_app/features/products/data/product_model.dart';
import 'package:fake_products_app/features/products/data/rating_model.dart';
import 'package:fake_products_app/features/products/presentation/product_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  Future<List<ProductModel>> _fetchProducts() async {
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

  @override
  void initState() {
    _fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        centerTitle: true,
      ),
      body: Container(
        child: FutureBuilder(
          future: _fetchProducts(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(child: Center(child: Text('Loading...')));
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailPage(
                                productEntity: snapshot.data[index]),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 2.0),
                        child: Card(
                          elevation: 2.0,
                          child: Container(
                            width: double.infinity,
                            height: 500.0,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10.0),
                                  child: Column(
                                    children: <Widget>[
                                      ListTile(
                                        leading: Container(
                                          width: 50.0,
                                          height: 50.0,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black45,
                                                offset: Offset(0, 2),
                                                blurRadius: 6.0,
                                              ),
                                            ],
                                          ),
                                          child: CircleAvatar(
                                              backgroundColor: Colors.black45,
                                              child: Text(snapshot
                                                  .data[index].id
                                                  .toString())),
                                        ),
                                        title: Text(
                                          snapshot.data[index].title.toString(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        subtitle: Text(snapshot
                                            .data[index].title
                                            .toString()),
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(10.0),
                                        width: double.infinity,
                                        height: 340.0,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          child: Image.network(
                                            snapshot.data[index].image,
                                            fit: BoxFit.fitHeight,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
