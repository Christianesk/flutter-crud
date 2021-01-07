import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_crud/src/blocs/validators.dart';

class LoginBloc with Validators{
  
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();


  // Get data of Stream
  Stream<String> get emailStream => _emailController.stream.transform(validateEmail);
  Stream<String> get passwordStream => _passwordController.stream.transform(validatePassword);
  Stream<bool> get formValidStream => Rx.combineLatest2(emailStream, passwordStream, (email, pass) => true);

  //Insert values to Stream

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;


  //Get lasted value 

  String get email => _emailController.value;
  String get password => _passwordController.value;

  dispose(){
    _emailController?.close();
    _passwordController?.close();
  }
}