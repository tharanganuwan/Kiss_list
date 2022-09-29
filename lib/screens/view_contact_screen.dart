import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kiss_list/model/contact_model.dart';
import 'package:kiss_list/screens/edit_add_contct_screen.dart';
import 'package:kiss_list/screens/home_screen.dart';
import 'package:kiss_list/utills/constants.dart';
import 'package:kiss_list/widget/widget.dart';
import 'package:kiss_list/widget/widget_view.dart';
import 'package:provider/provider.dart';

import '../providers/contact_provider.dart';

class ViewContactScreen extends StatefulWidget {
  const ViewContactScreen({
    Key? key,
    required this.contactModel,
  }) : super(key: key);
  final ContactModel contactModel;
  @override
  State<ViewContactScreen> createState() => _ViewContactScreenState();
}

class _ViewContactScreenState extends State<ViewContactScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        width: size.width,
        height: size.height + 50,
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
        child: Consumer<ContactProvider>(builder: (context, value, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                children: [
                  SizedBox(
                      width: size.width,
                      height: 300,
                      child: Image.network(widget.contactModel.img.toString())),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 25,
                      left: 20,
                      right: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomeScreen(),
                              ),
                            );
                          },
                          child: Icon(
                            Icons.home_outlined,
                            color: Color.fromARGB(255, 0, 0, 0),
                            size: 35,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditAddContactScreen(),
                              ),
                            );
                          },
                          child: Icon(
                            Icons.mode_edit_outlined,
                            color: Color.fromARGB(255, 0, 0, 0),
                            size: 35,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 280),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            LeftContaner1(
                              text: widget.contactModel.name.toString(),
                              width: 250,
                            ),
                            RightContaner1(
                              text: "X/10",
                              width: 95,
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            LeftContaner1(
                              text: widget.contactModel.gender.toString(),
                              width: 200,
                            ),
                            SizedBox(width: 10),
                            CenterContaner1(
                              text: widget.contactModel.age.toString(),
                              width: 140,
                            )
                          ],
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            LeftContaner1(
                              text: widget.contactModel.date.toString(),
                              width: 200,
                            ),
                            RightContaner1(
                              text: "X/10",
                              width: 95,
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: LeftContaner1(
                            text: widget.contactModel.notices.toString(),
                            height: 150,
                            width: size.width - 20,
                          ),
                        ),
                        SizedBox(height: 30),
                      ],
                    ),
                  )
                ],
              ),
              BottomContaner1(
                  height: 120,
                  width: size.width - 10,
                  text: widget.contactModel.about.toString())
            ],
          );
        }),
      ),
    ));
  }
}
