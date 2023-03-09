import 'package:flutter/material.dart';

class InputDecorations {
  static InputDecoration authInputDecoration({
    required String hintText, 
    required String labelText,
    IconData? suffixIcon
  }) {
    return InputDecoration(
      
      enabledBorder: const UnderlineInputBorder(
        
        borderSide: BorderSide(
          color: Colors.transparent,
        ),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
      ),
      hintText: hintText,
      labelText: labelText,
      labelStyle: const TextStyle(color: Colors.grey),
      suffixIcon: suffixIcon != null ? Icon(
        suffixIcon,
        color: const Color.fromRGBO(93, 240, 152, 1),
      ): null,
    );
  }
}
