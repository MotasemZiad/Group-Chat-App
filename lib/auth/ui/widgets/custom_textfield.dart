import 'package:flutter/material.dart';
import 'package:gsg_firebase/utils/constants.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool isObscure;
  final Function onChanged;
  final FocusNode focusNode;

  const CustomTextField({
    this.label,
    this.controller,
    this.keyboardType,
    this.hint,
    this.isObscure = false,
    this.onChanged,
    this.focusNode,
  });
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
          borderRadius,
        )),
        labelText: label,
        hintText: hint,
      ),
      focusNode: focusNode,
      keyboardType: keyboardType,
      cursorHeight: 22.0,
      obscureText: isObscure,
      onChanged: onChanged,
    );
  }
}
