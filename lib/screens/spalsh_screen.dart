import 'package:flutter/material.dart';
import 'package:kiss_list/screens/home_screen.dart';
import 'package:kiss_list/utills/constants.dart';

class SpalshScrren extends StatefulWidget {
  const SpalshScrren({Key? key}) : super(key: key);

  @override
  State<SpalshScrren> createState() => _SpalshScrrenState();
}

class _SpalshScrrenState extends State<SpalshScrren> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 36, 32, 32),
              Color.fromARGB(255, 214, 81, 125),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Container(
            child: Image.asset(
              Constants.imageAssets('logo.png'),
            ),
          ),
        ),
      ),
    );
  }
}
