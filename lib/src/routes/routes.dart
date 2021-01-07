

import 'package:flutter/cupertino.dart';
import 'package:flutter_crud/src/pages/home_page.dart';
import 'package:flutter_crud/src/pages/login_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes(){
  return <String, WidgetBuilder>{
    'login': (BuildContext context) => LoginPage(),
    'home': (BuildContext context) => HomePage(),
  };
}