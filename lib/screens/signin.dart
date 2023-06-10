import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:stocks_app/screens/home.dart';
import 'package:stocks_app/widgets/blink_loading.dart';
import 'package:stocks_app/widgets/signin_signup.dart';
import 'package:stocks_app/screens/signup.dart';


class SignInScreen extends StatefulWidget {

  const SignInScreen({super.key});

  @override
    _SignInScreenState createState() => _SignInScreenState();

}

class _SignInScreenState extends State<SignInScreen> {

  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _phoneNumTextController = TextEditingController();
  
  Image signInImageWidget(String imageName){
    return  Image.asset(
        width: double.infinity.w,
        height: 33.75.h,
        scale:0.5,
        imageName,
        fit: BoxFit.fill,
    );
  }

  @override
  Widget build(BuildContext context) {
          return Scaffold(
            body: Container(
              height: double.infinity.h,
              color: Colors.black,
              //   decoration: const  BoxDecoration(
              //     gradient: LinearGradient(colors:
              //     [ Colors.black, Colors.black87,],
              //     // [ Color(0xff000000), Color(0xff130F40),],
              //       begin: Alignment.topCenter,
              //       end: Alignment.bottomCenter,
              //     ),
              // ),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding:  EdgeInsets.only(top: 4.5.h),
                      child: signInImageWidget(
                          './assets/images/signin_screen_image.png'),
                    ),
                    SizedBox(height: 10.1.h,),
                    SizedBox(width: 85.16.w,
                        child: textFieldWidget(
                            context, "Phone Number", Icons.verified_user, false,
                            true, _phoneNumTextController)),
                    SizedBox(height: 2.25.h,),
                    SizedBox(width: 85.16.w,
                        child: textFieldWidget(
                            context, "Password", Icons.lock, true, false,
                            _passwordTextController)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(onPressed: () {},
                            child: const Text(
                              'Forgot Password?', style: TextStyle(
                                color: Colors.white60),)),
                        TextButton(onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const SignUpScreen()
                          ));
                          _passwordTextController.clear();
                          _phoneNumTextController.clear();
                        },
                            child: const Text(
                                "Don't have an account?", style: TextStyle(
                                color: Colors.white60))),
                      ],
                    ),
                    SizedBox(height: 3.37.h),
                    SizedBox(
                        width: 73.w,
                        child: signInSignUpButton('LOG IN', () async {
                          (_passwordTextController.text == "" ||
                              _phoneNumTextController.text == "")
                              ?
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Text Fields can't be empty")))
                              :
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => BlinkLoading()));
                          try {
                            var db = await FirebaseFirestore.instance
                                .collection(
                                'UserData').
                            doc(_phoneNumTextController.text).get().timeout(const Duration(seconds: 6));
                            if (!db.exists == true) {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => const SignInScreen()
                                  ),
                                      (Route<dynamic> route) => false);
                              _passwordTextController.clear();
                              _phoneNumTextController.clear();
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Invalid Phone Number')));
                            }
                            else
                            if (db['password'] == _passwordTextController.text) {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => const HomeScreen()
                                  ),
                                      (Route<dynamic> route) => false);
                              _passwordTextController.clear();
                              _phoneNumTextController.clear();
                            } else {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => const SignInScreen()
                                  ),
                                      (Route<dynamic> route) => false);
                              _passwordTextController.clear();
                              _phoneNumTextController.clear();
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Incorrect Password')));
                            }
                          }catch(e){
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Check your internet connection and try again')));
                          }

                        })
                    ),


                  ],
                ),
              ),
            ),
          );
  }
}