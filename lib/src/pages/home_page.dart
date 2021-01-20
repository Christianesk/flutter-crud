import 'package:flutter/material.dart';
import 'package:flutter_crud/src/blocs/provider.dart';
import 'package:flutter_crud/src/models/product_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {

    final productBloc = Provider.productBloc(context);
    productBloc.getProducts();

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: _createList(productBloc),
      floatingActionButton: _createButton(context),
    );
  }

  _createButton(BuildContext context) {
    return FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.deepPurple,
        onPressed: () => Navigator.pushNamed(context, 'product').then((value) {
              setState(() {});
            }));
  }

  Widget _createList(ProductBloc productBloc) {

    return StreamBuilder(
      stream: productBloc.productStream,
      builder:  (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
        if (snapshot.hasData) {
          final products = snapshot.data;

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) =>
                _createItem(context, products[index],productBloc),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );

  }

  Widget _createItem(BuildContext context, ProductModel product,ProductBloc productBloc) {
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
              Icon(Icons.delete_forever_outlined,
                  color: Colors.white, size: 35.0)
            ],
          ),
        ),
        onDismissed: (direction) => productBloc.deleteProduct(product.id),
        child: Card(
          child: Column(
            children: <Widget>[
              (product.photoUrl == null)
                  ? Image(image: AssetImage('assets/img/no-image.png'))
                  : FadeInImage(
                      image: NetworkImage(product.photoUrl),
                      placeholder: AssetImage('assets/img/jar-loading.gif'),
                      height: 300.0,
                      width: double.infinity,
                      fit: BoxFit.cover),
              ListTile(
                title: Text('${product.title} - ${product.value}'),
                subtitle: Text(product.id),
                onTap: () =>
                    Navigator.pushNamed(context, 'product', arguments: product)
                        .then((value) {
                  setState(() {});
                }),
              ),
            ],
          ),
        ));
  }
}
