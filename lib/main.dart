import 'package:flutter/material.dart';
import 'package:flutter_crud/src/blocs/provider.dart';
import 'package:flutter_crud/src/routes/routes.dart';
import 'package:flutter_crud/src/user_preferences/user_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new UserPreferences();
  await prefs.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final prefs = new UserPreferences();
    print(prefs.token);
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'login',
        routes: getApplicationRoutes(),
        theme: ThemeData(primaryColor: Colors.deepPurple),
      ),
    );
  }
}
