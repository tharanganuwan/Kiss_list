import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kiss_list/utills/constants.dart';

class ViewContactScreen extends StatefulWidget {
  const ViewContactScreen({Key? key}) : super(key: key);

  @override
  State<ViewContactScreen> createState() => _ViewContactScreenState();
}

class _ViewContactScreenState extends State<ViewContactScreen> {
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
        child: Container(
          // padding: EdgeInsets.only(
          //   top: 25,
          //   left: 20,
          //   right: 20,
          // ),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                      height: 300,
                      child: Image.asset(
                        Constants.imageAssets('profile.png'),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 25,
                      left: 20,
                      right: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.home_filled,
                          color: Color.fromARGB(255, 0, 0, 0),
                          size: 35,
                        ),
                        Icon(
                          Icons.edit,
                          color: Color.fromARGB(255, 0, 0, 0),
                          size: 35,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Container(
              //   padding: const EdgeInsets.symmetric(horizontal: 20),
              //   height: 58,
              //   width: double.infinity,
              //   decoration: BoxDecoration(
              //     color: Colors.red,
              //     borderRadius: BorderRadius.circular(5),
              //   ),
              //   child: Align(alignment: Alignment.centerLeft, child: Text("a")),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
