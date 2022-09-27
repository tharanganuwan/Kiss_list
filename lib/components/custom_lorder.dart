import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomLorder extends StatelessWidget {
  const CustomLorder({Key? key, this.lcolor = Colors.grey}) : super(key: key);

  final Color lcolor;

  @override
  Widget build(BuildContext context) {
    return SpinKitCircle(
      color: lcolor,
      size: 60.0,
    );
  }
}
