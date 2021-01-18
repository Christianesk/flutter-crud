

import 'package:flutter/cupertino.dart';
import 'package:flutter_crud/src/pages/home_page.dart';
import 'package:flutter_crud/src/pages/login_page.dart';
import 'package:flutter_crud/src/pages/product_page.dart';
import 'package:flutter_crud/src/pages/signup_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes(){
  return <String, WidgetBuilder>{
    'login': (BuildContext context) => LoginPage(),
    'signup': (BuildContext context) => SignupPage(),
    'home': (BuildContext context) => HomePage(),
    'product': (BuildContext context) => ProductPage(),
  };
}