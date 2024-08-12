import 'package:flutter/material.dart';

InputDecoration getFormFieldDecoration(String labelText) {
  return InputDecoration(
    labelText: labelText,
    labelStyle: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
    enabledBorder: const UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.white,
      ),
    ),
    disabledBorder: const UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.white,
      ),
    ),
  );
}