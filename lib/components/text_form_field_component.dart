import 'package:flutter/material.dart';

class TextFormFieldComponent extends StatelessWidget {
  TextFormFieldComponent({
    super.key,
    required this.label,
    required this.keyboardType,
    required this.controller,
    required this.icon,
  });
  String label;
  TextEditingController controller;
  Icon icon;
  TextInputType keyboardType;
  String? value;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      onChanged: (value) => value,
      decoration: InputDecoration(
        icon: icon,
        hintText: label,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
          gapPadding: 20,
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );
  }
}
