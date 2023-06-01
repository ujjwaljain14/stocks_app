import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stocks_app/screens/phone_verify.dart';
import 'package:stocks_app/widgets/signin_signup.dart';

class SignUpScreen extends StatefulWidget{
  const SignUpScreen({super.key,});
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final TextEditingController _firstNameTextController = TextEditingController();
  final TextEditingController _lastNameTextController = TextEditingController();
  final TextEditingController _phoneNumberTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  bool _isVerified = false;

  @override
  Widget build(BuildContext context) {

    Widget pno = TextField(
      onChanged: (text){
        if(_isVerified){
          setState(() {
            _isVerified = false;
          });
        }
      },

      controller: _phoneNumberTextController,
      maxLength: 10,
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 20),
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.phone , color: Colors.white,),
          prefixText: '+91 ' ,
          suffix: (_isVerified) ?
          const Icon(Icons.verified, color: Colors.green,) :
          TextButton(onPressed: ()async{
          if(_phoneNumberTextController.text.length == 10){
              _isVerified = await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) =>
              PhoneVerifyScreen(phoneNumber: _phoneNumberTextController.text)
              ),
              );
          }else{
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Enter a valid phone number')));
          }
            if(_isVerified){
              setState(() {
                _isVerified;
              });
            }
          },
            style: TextButton.styleFrom(
              padding: const EdgeInsets.only(right: 10),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              minimumSize: const Size.square(2),) ,
            child: const Text('Verify', style: TextStyle(color:Colors.white),),
          ),
          prefixStyle: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          labelText: 'Phone Number',
          labelStyle: TextStyle(
              color: Colors.white60.withOpacity(0.9), fontSize: 18),
          filled: true,
          fillColor: Colors.white.withOpacity(0.2),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(width: 0, style: BorderStyle.none))
      ),
      keyboardType:TextInputType.number,
    );


    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up', style: TextStyle(fontSize: 24)),
        backgroundColor: Colors.black87,
      ),
      body: Container(
        height: double.infinity,
        decoration: const  BoxDecoration(
          gradient: LinearGradient(colors: [ Colors.black, Colors.black87,],
            // [ Color(0xff000000), Color(0xff130F40),],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(height:90, width: double.infinity,),
              SizedBox(width:350, child: textFieldWidget(context, 'First Name', Icons.person, false, false,_firstNameTextController)),
              const SizedBox(height:20),
              SizedBox(width:350, child: textFieldWidget(context, 'Last Name', Icons.person, false, false, _lastNameTextController)),
              const SizedBox(height:20),
              SizedBox(width:350, child: pno),
              const SizedBox(height:20),
              SizedBox(width:350, child: textFieldWidget(context, 'Email Id', Icons.email, false, false, _emailTextController)),
              const SizedBox(height:20),
              SizedBox(width:350, child: textFieldWidget(context, 'Password', Icons.lock, true, false, _passwordTextController)),
              const SizedBox(height:50),
              SizedBox(
                width: 300,
                child: signInSignUpButton('SIGN UP', () {
                  String text="";
                  if(_firstNameTextController.text == ''){
                    text = "First Name can't be empty";
                  }else if(_lastNameTextController.text == ''){
                    text = "Last Name can't be empty";
                  }else if(_isVerified == false){
                    text = "Phone number must be verified";
                  }else if(_emailTextController.text == ''){
                    text = "Email can't be empty";
                  }else if(_passwordTextController.text.length < 8){
                    text = "Password must contain 8 characters";
                  }else{
                    FirebaseFirestore.instance.collection('UserData').
                      doc(_phoneNumberTextController.text).set({
                        "firstName":_firstNameTextController.text,
                        "lastName":_lastNameTextController.text,
                        "email":_emailTextController.text,
                        "password":_passwordTextController.text,
                    });
                    Navigator.of(context).pop();
                  }
                  if(text.isNotEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}