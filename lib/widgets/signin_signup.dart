import 'package:flutter/material.dart';
import 'package:stocks_app/screens/phone_verify.dart';

TextField textFieldWidget(context, String text, IconData icon, bool isPasswordType, bool isPhoneNum, TextEditingController controller,{bool isVerified=false, bool isSignUp = false}) {
  return TextField(controller: controller,
    maxLength: isPhoneNum ? 10 : TextField.noMaxLength,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.white,
    style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 20),
    decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.white,),
        prefixText: isPhoneNum ? '+91 ' : '',
        suffix: (isVerified) ?
          const Icon(Icons.verified, color: Colors.green,) :
          (isSignUp) ?
            TextButton(onPressed: ()async{
              isVerified = await Navigator.of(context).push(
                MaterialPageRoute(builder: (context) =>
                    PhoneVerifyScreen(phoneNumber: controller.text)
                ),
              );
              if(isVerified){
                textFieldWidget(context, text, icon, isPasswordType, isPhoneNum, controller,isVerified: true);
              }
            },
              style: TextButton.styleFrom(
                padding: const EdgeInsets.only(right: 10),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                minimumSize: const Size.square(2),) ,
              child: const Text('Verify', style: TextStyle(color:Colors.white),),) :
          const Text(''),
        prefixStyle: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        labelText: text,
        labelStyle: TextStyle(
            color: Colors.white60.withOpacity(0.9), fontSize: 18),
        filled: true,
        fillColor: Colors.white.withOpacity(0.2),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(width: 0, style: BorderStyle.none))
    ),
    keyboardType: !isPhoneNum ? TextInputType.text : TextInputType.number,
  );
}

  Container signInSignUpButton(String label, VoidCallback onTap,{bool isProcessing = false}){
    return Container(
      height:50,
      width: 350,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
      child: ElevatedButton(
        onPressed: () {
          // isProcessing = true;
          onTap();
          // isProcessing = false;
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states){
            if(states.contains(MaterialState.pressed)){
              return Colors.black26;
            }else{
              return Colors.white;
            }
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
          ),
        ),
        child:
          isProcessing?
            const CircularProgressIndicator(color: Colors.black,)
              :
              Text(
                label,
                style: const TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
      ),
    );
  }