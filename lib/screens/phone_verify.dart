import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:stocks_app/widgets/signin_signup.dart';

class PhoneVerifyScreen extends StatefulWidget{

  const PhoneVerifyScreen({
    super.key,
    required this.phoneNumber,
  });
  final String phoneNumber;

  static String verify="";

  @override
  State<PhoneVerifyScreen> createState() => _PhoneVerifyScreenState();
}

class _PhoneVerifyScreenState extends State<PhoneVerifyScreen> {

  @override
  void initState(){
    super.initState();
    otpSendingMethod();
  }

  otpSendingMethod(){
    auth.verifyPhoneNumber(
      phoneNumber: '+91 ${widget.phoneNumber}',
      verificationCompleted: (PhoneAuthCredential credential) async{
        await auth.signInWithCredential(credential);
        Navigator.of(context).pop(true);
      },
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {
        PhoneVerifyScreen.verify = verificationId;

      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }


  FirebaseAuth auth = FirebaseAuth.instance;
  var finalCode="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Verify', style: TextStyle(fontSize: 24)),
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
          child: Column(

            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            children: [
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(left: 12),
                    child: const Text(
                        'Verification Code',
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold)
                    ),
                  ),

                  const SizedBox(height: 15,),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(left: 30),
                    child: const Text(
                        'We texted you a code\nPlease enter it below',
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.white, fontSize: 20,)
                    ),
                  ),
                ],
              ),

              OtpTextField(
                numberOfFields: 6,
                cursorColor: Colors.white60,
                focusedBorderColor: Colors.green.shade500,
                textStyle: const TextStyle(color: Colors.white),
                showFieldAsBox: true,
                onCodeChanged: (String code){
                },
                onSubmit: (String verificationCode){
                  finalCode = verificationCode;
                  showDialog(context: context, builder: (context){
                    return AlertDialog(
                      title: const Text('Verification Code'),
                      content: Text('Code entered is $verificationCode'),
                    );
                  });
                },
              ),


              Column(
                children: [
                  const Text(
                      'This helps us verify every user in our market place',
                      style: TextStyle(color: Colors.white, fontSize: 15, )
                  ),

                  TextButton(
                    onPressed: (){},
                    child: const Text(
                        "Didn't get code?",
                        style: TextStyle(color: Colors.white, fontSize: 15, )
                    ),
                  ),
                  const SizedBox(height: 40,),
                  signInSignUpButton('Verify', ()async{
                    try {
                      PhoneAuthCredential credential =
                      PhoneAuthProvider.credential(
                        verificationId: PhoneVerifyScreen.verify,
                        smsCode: finalCode,
                      );

                      await auth.signInWithCredential(credential);
                      Navigator.of(context).pop(true);
                    }catch(e){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString()),));
                    }
                  }),
                ],
              ),
            ],
          ),
        )
    );
  }
}