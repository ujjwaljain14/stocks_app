import 'package:flutter/material.dart';
import 'package:stocks_app/screens/home.dart';
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
        width: double.infinity,
        height: 300,
        scale:0.5,
        imageName,
        fit: BoxFit.fill,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
            height: double.infinity,
            decoration: const  BoxDecoration(
              gradient: LinearGradient(colors:
              [ Colors.black, Colors.black87,],
              // [ Color(0xff000000), Color(0xff130F40),],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
          ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget> [
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: signInImageWidget('./assets/images/signin_screen_image.png'),
              ),
              const SizedBox(height: 90,),
              SizedBox(width: 350, child: textFieldWidget(context, "Phone Number", Icons.verified_user, false, true,_phoneNumTextController)),
              const SizedBox(height: 20,),
              SizedBox(width: 350, child: textFieldWidget(context, "Password", Icons.lock, true, false ,_passwordTextController)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(onPressed: (){}, child: const Text('Forgot Password?', style: TextStyle(color: Colors.white60),)),
                  TextButton(onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SignUpScreen()
                    ));
                    _passwordTextController.clear();
                    _phoneNumTextController.clear();
                  }, child: const Text("Don't have an account?", style: TextStyle(color: Colors.white60))),
                ],
              ),
              const SizedBox(height: 30),
              SizedBox(
                  width:300,
                  child: signInSignUpButton('LOG IN', (){
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const HomeScreen()));
                            _passwordTextController.clear();
                            _phoneNumTextController.clear();
                          })
              ),


            ],
          ),
        ),
      ),
    );
  }
}