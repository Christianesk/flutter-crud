import 'dart:convert';
import 'dart:io';
import 'package:flutter_crud/src/user_preferences/user_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';
import 'package:flutter_crud/src/config/config.dart';
import 'package:flutter_crud/src/models/product_model.dart';

class ProductProvider {
  final String _url = urlFirebase;
  final _prefs = new UserPreferences();

  Future<bool> createProduct(ProductModel product) async {
    final url = '$_url/products.json?auth=${_prefs.token}';

    final resp = await http.post(url, body: productModelToJson(product));

    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }

  Future<bool> editProduct(ProductModel product) async {

    final url = '$_url/products/${product.id}.json?auth=${_prefs.token}';

    final resp = await http.put(url, body: productModelToJson(product));

    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }

  Future<List<ProductModel>> getProducts() async {
    final url = '$_url/products.json?auth=${_prefs.token}';

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

    final url = '$_url/products/$id.json?auth=${_prefs.token}';

    final resp = await http.delete(url);

    return 1;
  }

  Future<String> uploadImage(File image) async {
    final url = Uri.parse(urlCloudinary);

    final mimeType = mime(image.path).split('/');

    final imageUploadRequest = http.MultipartRequest(
      'POST',
      url
    );

    final file = await http.MultipartFile.fromPath(
      'file',
      image.path,
      contentType: MediaType( mimeType[0], mimeType[1])
    );

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();

    final res = await http.Response.fromStream(streamResponse);

    if (res.statusCode != 200 && res.statusCode != 201) {
      return null;
    }

    final resData = json.decode(res.body);

    print(resData);
    return resData['secure_url'];

  }
}
