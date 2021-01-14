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

  final scaffoldKey = GlobalKey<ScaffoldState>();

  ProductModel  product = new ProductModel();

  bool _saving = false;

  final productProvider = new ProductProvider();

  @override
  Widget build(BuildContext context) {


    final ProductModel prodData = ModalRoute.of(context).settings.arguments;

    if (prodData != null) {
      product = prodData;
    }

    return Scaffold(
      key: scaffoldKey,
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
      label: product.id == null ?Text('Save'):Text('Edit'),
      icon: Icon(Icons.save),
      onPressed: (_saving)? null : _submit,
    );
  }

  void _submit(){
    if (!formKey.currentState.validate()) return;

    formKey.currentState.save();
    
    setState(() =>_saving = true);

    if (product.id == null) {
      productProvider.createProduct(product);
      showSnackbar('Saved record!');
    }else {
      productProvider.editProduct(product);
      showSnackbar('Modified record!');
    }
    

    Navigator.pop(context);

    
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

  void showSnackbar(String message){
    final snackbar = SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: 3500),
    );

    scaffoldKey.currentState.showSnackBar(snackbar);
  }
}