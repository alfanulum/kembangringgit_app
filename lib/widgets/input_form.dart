import 'package:flutter/material.dart';

class InputForm extends StatelessWidget {
  const InputForm({
    Key? key,
    required this.controller,
    required this.text,
    required this.obscure,
    required this.type,
  }) : super(key: key);

  final TextEditingController controller;
  final String text;
  final bool obscure;
  final TextInputType type;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 5)
          ]),
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        obscureText: obscure,
        decoration: InputDecoration(hintText: text, border: InputBorder.none),
      ),
    );
  }
}
