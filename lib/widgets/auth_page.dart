import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stocks_app/screens/home.dart';
import 'package:stocks_app/screens/signin.dart';

class AuthPage extends StatelessWidget{

  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            // user logged in
            return const HomeScreen();
          }else{
            //user not logged in
            return const SignInScreen();
          }
        },
      ),
    );
  }
}