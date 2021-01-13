import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_crud/src/config/config.dart';
import 'package:flutter_crud/src/models/product_model.dart';

class ProductProvider {
  final String _url = urlFirebase;

  Future<bool> createProduct(ProductModel product) async {
    final url = '$_url/products.json';

    final resp = await http.post(url, body: productModelToJson(product));

    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }

  Future<bool> editProduct(ProductModel product) async {

    final url = '$_url/products/${product.id}.json';

    final resp = await http.put(url, body: productModelToJson(product));

    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }

  Future<List<ProductModel>> getProducts() async {
    final url = '$_url/products.json';

    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);

    final List<ProductModel> products = new List();

    if (decodedData == null) return [];

    decodedData.forEach((id, product) {
      final prodTemp = ProductModel.fromJson(product);
      prodTemp.id = id;

      products.add(prodTemp);
    });


    return products;
  }

  Future<int> deleteProduct(String id) async {

    final url = '$_url/products/$id.json';

    final resp = await http.delete(url);

    return 1;
  }
}
