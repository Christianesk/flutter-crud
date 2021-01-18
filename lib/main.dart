import 'package:flutter/material.dart';
import 'package:flutter_crud/src/blocs/provider.dart';
import 'package:flutter_crud/src/routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Material App',
          initialRoute: 'login',
          routes: getApplicationRoutes(),
          theme: ThemeData(
            primaryColor: Colors.deepPurple
          ),
        ),
    );
  }
}
