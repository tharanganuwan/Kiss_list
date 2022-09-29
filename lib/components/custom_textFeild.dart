import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextFeild extends StatelessWidget {
  CustomTextFeild({
    Key? key,
    this.hint,
    required this.controller,
    this.widget,
    this.align = TextAlign.start,
  }) : super(key: key);

  final String? hint;
  final TextEditingController controller;
  final Widget? widget;
  final TextAlign align;
  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: align,
      controller: controller,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        prefixIcon: widget,
        fillColor: Colors.white,
        filled: true,
        hintText: hint,
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(15)),
        // focusedBorder: OutlineInputBorder(
        //     borderSide: BorderSide(color: Colors.black),
        //     borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}
