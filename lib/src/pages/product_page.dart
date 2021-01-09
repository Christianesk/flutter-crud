import 'package:flutter/material.dart';
import 'package:flutter_crud/src/models/product_model.dart';
import 'package:flutter_crud/src/providers/product_provider.dart';
import 'package:flutter_crud/src/utils/utils.dart' as utils;


class ProductPage extends StatefulWidget {

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

  final formKey = GlobalKey<FormState>();

  ProductModel  product = new ProductModel();

  final productProvider = new ProductProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Product'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: () {
              
            },
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: () {
              
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                _createName(),
                _createPrice(),
                _createAvailable(),
                _createButton()
              ],
            ),
          ),
        ),
      ),
      
    );
  }

  Widget _createName() {
    return TextFormField(
      initialValue: product.title,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Product',
      ),
      onSaved: (newValue) => product.title = newValue,
      validator: (value) {
        if (value.length < 3) {
          return 'Enter product name';
        }else{
          return null;
        }
      },
    );
  }

  Widget _createPrice() {
    return TextFormField(
      initialValue: product.value.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Price',
      ),
      onSaved: (newValue) => product.value = double.parse(newValue),
      validator: (value) {
        if (utils.isNumeric(value)) {
          return null;
        }else{
          return 'Only numbers';
        }
      },
    );
  }

  Widget _createButton() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: Colors.deepPurple,
      textColor: Colors.white,
      label: Text('Save'),
      icon: Icon(Icons.save),
      onPressed: _submit,
    );
  }

  void _submit(){
    if (!formKey.currentState.validate()) return;

    formKey.currentState.save();

    productProvider.createProduct(product);
  }

  Widget _createAvailable() {
    return SwitchListTile(
      value: product.available,
      title: Text('Available'),
      activeColor: Colors.deepPurple,
      onChanged: (value) => setState((){
        product.available = value;
      }),
    );
  }
}