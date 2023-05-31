import 'package:flutter/material.dart';

TextField textFieldWidget(String text, IconData icon, bool isPasswordType, bool isPhoneNum, TextEditingController controller) {
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

  Container signInSignUpButton(bool isLogin, VoidCallback onTap){
    return Container(
      height:50,
      width: 350,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
      child: ElevatedButton(
        onPressed: onTap,
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
        child: Text(
          isLogin ? 'LOG IN' : 'SIGN UP',
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }