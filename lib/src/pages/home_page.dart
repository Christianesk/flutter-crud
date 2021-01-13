import 'package:flutter/material.dart';
import 'package:flutter_crud/src/blocs/provider.dart';
import 'package:flutter_crud/src/models/product_model.dart';
import 'package:flutter_crud/src/providers/product_provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final productProvider = new ProductProvider();

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: _createList(),
      floatingActionButton: _createButton(context),
    );
  }

  _createButton(BuildContext context) {
    return FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.deepPurple,
        onPressed: () => Navigator.pushNamed(context, 'product').then((value){setState(() { });})
    );
  }

  Widget _createList() {
    return FutureBuilder(
      future: productProvider.getProducts(),
      builder:
          (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
        if (snapshot.hasData) {
          final products = snapshot.data;

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) =>
                _createItem(context, products[index]),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _createItem(BuildContext context, ProductModel product) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Icon(Icons.delete_forever_outlined,
                color: Colors.white, size: 35.0),
            SizedBox(width: 150.0),
            Icon(Icons.delete_forever_outlined, color: Colors.white, size: 35.0)
          ],
        ),
      ),
      onDismissed: (direction) {
        productProvider.deleteProduct(product.id);
      },
      child: ListTile(
        title: Text('${product.title} - ${product.value}'),
        subtitle: Text(product.id),
        onTap: () => Navigator.pushNamed(context, 'product',arguments: product).then((value){setState(() { });}),
      ),
    );
  }
}
