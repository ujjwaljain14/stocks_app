import 'package:flutter/material.dart';
import 'package:stocks_app/widgets/signin_signup.dart';

class SignUpScreen extends StatefulWidget{
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final TextEditingController _firstNameTextController = TextEditingController();
  final TextEditingController _lastNameTextController = TextEditingController();
  final TextEditingController _phoneNumberTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: const  BoxDecoration(
          gradient: LinearGradient(colors: [ Color(0xff000000), Color(0xff130f40),],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(height:160),
              textFieldWidget('First Name', Icons.person, false, false,_firstNameTextController),
              const SizedBox(height:20),
              textFieldWidget('Last Name', Icons.person, false, false, _lastNameTextController),
              const SizedBox(height:20),
              textFieldWidget('Phone Number', Icons.person, false, true, _phoneNumberTextController),
              const SizedBox(height:20),
              textFieldWidget('Email Id', Icons.person, false, false, _emailTextController),
              const SizedBox(height:20),
              textFieldWidget('Password', Icons.person, true, false, _passwordTextController),
              const SizedBox(height:60),
              signInSignUpButton(false, ()=>Navigator.of(context).pop()),
            ],
          ),
        ),
      ),
    );
  }
}