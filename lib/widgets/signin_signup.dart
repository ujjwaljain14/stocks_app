import 'package:flutter/material.dart';
import 'package:stocks_app/screens/phone_verify.dart';
import 'package:sizer/sizer.dart';

TextField textFieldWidget(context, String text, IconData icon, bool isPasswordType, bool isPhoneNum, TextEditingController controller,{bool isVerified=false, bool isSignUp = false}) {
  return TextField(controller: controller,
    maxLength: isPhoneNum ? 10 : TextField.noMaxLength,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.white,
    style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 15.sp),
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
                padding: EdgeInsets.only(right: 10.h),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                minimumSize: Size.square(0.2.h),) ,
              child: const Text('Verify', style: TextStyle(color:Colors.white),),)
              :
          const Text(''),
        prefixStyle: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15.sp),
        labelText: text,
        labelStyle: TextStyle(
            color: Colors.white60.withOpacity(0.9), fontSize: 13.5.sp),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(3.38.h),
            borderSide: const BorderSide(width: 0, style: BorderStyle.none))
    ),
    keyboardType: !isPhoneNum ? TextInputType.text : TextInputType.number,
  );
}

  Container signInSignUpButton(String label, VoidCallback onTap,{bool isProcessing = false}){
    return Container(
      height:5.6.h,
      width: 85.16.w,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.1.h)),
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
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.37.h))
          ),
        ),
        child:
          isProcessing?
            const CircularProgressIndicator(color: Colors.black,)
              :
              Text(
                label,
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.sp,
                ),
              ),
      ),
    );
  }