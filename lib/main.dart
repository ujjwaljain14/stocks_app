import 'package:flutter/material.dart';
import 'package:stocks_app/screens/signin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        home: SignInScreen(),
    ) ;

  }
}

