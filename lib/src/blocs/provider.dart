import 'package:flutter/material.dart';
import 'package:flutter_crud/src/blocs/login_bloc.dart';
export 'package:flutter_crud/src/blocs/login_bloc.dart';
import 'package:flutter_crud/src/blocs/product_bloc.dart';
export 'package:flutter_crud/src/blocs/product_bloc.dart';

class Provider extends InheritedWidget {

  final _loginBloc = new LoginBloc();

  final _productBloc = new ProductBloc();

  static Provider _instance;

  factory Provider({Key key, Widget child}) {
    if (_instance == null) {
      _instance = new Provider._internal(key: key, child: child);
    }

    return _instance;
  }

  Provider._internal({Key key, Widget child}) : super(key: key, child: child);

  

  // Provider({Key key, Widget child})
  //   : super(key: key,child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  static LoginBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>()._loginBloc;
  }

  static ProductBloc productBloc(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>()._productBloc;
  }
}
