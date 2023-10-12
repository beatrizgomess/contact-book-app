import 'package:flutter/material.dart';

class TextFormFieldComponent extends StatefulWidget {
  TextFormFieldComponent(
      {super.key,
      required this.label,
      required this.keyboardType,
      required this.controllerText,
      required this.icon,
      required this.value});
  String label;
  Icon icon;
  TextInputType keyboardType;
  String value;
  String controllerText;

  @override
  State<TextFormFieldComponent> createState() => _TextFormFieldComponentState();
}

class _TextFormFieldComponentState extends State<TextFormFieldComponent> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: TextEditingController(text: widget.controllerText),
      keyboardType: widget.keyboardType,
      onChanged: (value) {
        widget.value = value;
      },
      decoration: InputDecoration(
        icon: widget.icon,
        hintText: widget.label,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
          gapPadding: 20,
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );
  }
}
