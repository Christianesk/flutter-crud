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



  
}