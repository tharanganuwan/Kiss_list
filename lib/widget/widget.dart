import 'package:flutter/material.dart';
import 'package:kiss_list/components/custom_textFeild.dart';

class LeftContaner extends StatelessWidget {
  const LeftContaner({
    Key? key,
    required this.text,
    required this.width,
    this.height = 58,
    required this.controller,
  }) : super(key: key);
  final String text;
  final double width;
  final double height;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.horizontal(right: Radius.circular(50))),
      child: Container(
          child: CustomTextFeild(
        controller: controller,
        hint: text,
      )
          // Text(
          //     text,
          //     style: TextStyle(
          //       fontSize: 25,
          //       fontWeight: FontWeight.bold,
          //     ),
          //   ),
          ),
    );
  }
}

class RightContaner extends StatelessWidget {
  const RightContaner({
    Key? key,
    required this.width,
    required this.text,
    this.height = 58,
    required this.controller,
  }) : super(key: key);
  final double width;
  final String text;
  final double height;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.horizontal(left: Radius.circular(50)),
      ),
      child: Container(
        child: Center(
            child: CustomTextFeild(
          controller: controller,
          hint: text,
        )),
      ),
    );
  }
}

class CenterContaner extends StatelessWidget {
  const CenterContaner({
    Key? key,
    required this.text,
    required this.width,
    this.height = 58,
    required this.controller,
  }) : super(key: key);

  final String text;
  final double width;
  final double height;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Container(
        child: Center(
            child: CustomTextFeild(
          controller: controller,
          hint: text,
        )),
      ),
    );
  }
}

class BottomContaner extends StatelessWidget {
  const BottomContaner({
    Key? key,
    required this.height,
    required this.width,
    required this.text,
    required this.controller,
  }) : super(key: key);
  final double width;
  final double height;
  final String text;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
      ),
      child: Container(
        child: Center(
            child: CustomTextFeild(
          controller: controller,
          hint: text,
        )),
      ),
    );
  }
}
