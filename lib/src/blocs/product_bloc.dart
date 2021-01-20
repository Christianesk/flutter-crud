import 'dart:io';

import 'package:flutter_crud/src/providers/product_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_crud/src/models/product_model.dart';

class ProductBloc{


  final _productController = new BehaviorSubject<List<ProductModel>>();
  final _loadController = new BehaviorSubject<bool>();

  final _productProvider = new ProductProvider();

  Stream<List<ProductModel>> get productStream => _productController.stream;
  Stream<bool> get loadStream => _loadController.stream;


  void getProducts() async {
    final products = await _productProvider.getProducts();
    _productController.sink.add(products);
  }

  void createProduct(ProductModel product) async {
    _loadController.sink.add(true);
    await _productProvider.createProduct(product);
    _loadController.sink.add(false);
  }

  Future<String> uploadPhoto(File photo) async {
    _loadController.sink.add(true);
    final photoUrl = await _productProvider.uploadImage(photo);
    _loadController.sink.add(false);

    return photoUrl;
  }


  void editProduct(ProductModel product) async {
    _loadController.sink.add(true);
    await _productProvider.editProduct(product);
    _loadController.sink.add(false);
  }

  void deleteProduct(String id) async {
    _loadController.sink.add(true);
    await _productProvider.deleteProduct(id);
    _loadController.sink.add(false);
  }


  dispose(){
    _productController?.close();
    _loadController?.close();
  }
}