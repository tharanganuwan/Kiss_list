import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kiss_list/components/custom_button.dart';
import 'package:kiss_list/components/custom_textFeild.dart';
import 'package:kiss_list/controllers/contact_controller.dart';
import 'package:kiss_list/model/contact_model.dart';
import 'package:kiss_list/providers/contact_provider.dart';
import 'package:kiss_list/screens/home_screen.dart';
import 'package:kiss_list/utills/constants.dart';
import 'package:kiss_list/utills/util_functions.dart';
import 'package:kiss_list/widget/widget.dart';
import 'package:provider/provider.dart';

const List<String> list = <String>['Male  ♂', 'Female  ♀', 'Other  ♂♀'];

class AddContactScreen extends StatefulWidget {
  AddContactScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AddContactScreen> createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  String dropdownValue = list.first;
  @override
  // void initState() {
  //   // TODO: implement initState
  //   Provider.of<ContactProvider>(context, listen: false).genderController.text =
  //       list.first;
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Consumer<ContactProvider>(builder: (context, value, child) {
        return Column(
          children: [
            Container(
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        width: size.width,
                        height: 300,
                        child: value.getImg.path != ""
                            ? GestureDetector(
                                onTap: () {
                                  value.selectImage();
                                },
                                child: Image.file(
                                  value.getImg,
                                  width: size.width,
                                  height: size.width,
                                  fit: BoxFit.fill,
                                ),
                              )
                            : Image.asset(
                                Constants.imageAssets('profile.png'),
                                fit: BoxFit.cover,
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 140),
                        child: Center(
                          child: ClipOval(
                            child: GestureDetector(
                              onTap: () {
                                value.selectImage();
                              },
                              child: Container(
                                height: 60,
                                width: 60,
                                color: Colors.white,
                                child: Icon(Icons.mode_edit_outlined),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 25,
                          left: 20,
                          right: 20,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              color: Color.fromARGB(255, 26, 25, 25)
                                  .withOpacity(0.8),
                              child: GestureDetector(
                                onTap: () {
                                  value.startAddContactDetails(context);
                                },
                                child: Icon(
                                  Icons.save_outlined,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  size: 35,
                                ),
                              ),
                            ),
                            Container(
                              color: Color.fromARGB(255, 26, 25, 25)
                                  .withOpacity(0.8),
                              child: GestureDetector(
                                onTap: (() {
                                  value.cleardata();
                                }),
                                child: Icon(
                                  Icons.delete_outlined,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  size: 35,
                                ),
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
                                LeftContaner(
                                  text: "Name",
                                  width: 250,
                                  controller: value.nameController,
                                ),
                                RightContaner(
                                  text: "X/10",
                                  width: 95,
                                  controller: value.ratingController,
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  width: 200,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.horizontal(
                                          right: Radius.circular(50))),
                                  child: Container(
                                    width: 100,
                                    child: DropdownButton<String>(
                                      value: dropdownValue,
                                      // icon: const Icon(Icons.arrow_drop_down),
                                      //elevation: 16,
                                      iconSize: 20,
                                      isExpanded: true,
                                      style: const TextStyle(
                                          fontSize: 25,
                                          color: Color.fromARGB(255, 0, 0, 1)),
                                      onChanged: (String? value2) {
                                        // This is called when the user selects an item.
                                        setState(() {
                                          dropdownValue = value2!;
                                          value.genderController.text =
                                              value2.toString();
                                        });
                                      },
                                      items: list.map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                            value: value, child: Text(value));
                                      }).toList(),
                                    ),
                                  ),
                                ),
                                // LeftContaner(
                                //   text: "Gender ♂♀",
                                //   width: 200,
                                //   controller: value.genderController,
                                // ),
                                SizedBox(width: 10),
                                CenterContaner(
                                  text: "Age",
                                  width: 140,
                                  controller: value.ageController,
                                ),
                              ],
                            ),
                            SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(),
                                CenterContaner(
                                  text: "Date",
                                  width: 180,
                                  controller: value.dateController,
                                ),
                                RightContaner(
                                  text: "Rating",
                                  width: 145,
                                  controller: value.ratingController,
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(),
                                LeftContaner(
                                  text: "Notice",
                                  height: 110,
                                  width: size.width - 150,
                                  controller: value.noticesController,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  height: 110,
                                  width: 145,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.horizontal(
                                        left: Radius.circular(50)),
                                  ),
                                  child: Container(
                                    child: Center(
                                        child: IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () {
                                        value.cleardata();
                                      },
                                    )),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                value.aboutController.clear();
                                value.ageController.clear();
                                value.nameController.clear();
                                value.ratingController.clear();
                                value.dateController.clear();
                                value.noticesController.clear();
                                value.genderController.clear();
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                height: 50,
                                width: 300,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Container(
                                  child: Center(child: Text('Add Another')),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  BottomContaner(
                    height: 120,
                    width: size.width - 10,
                    text: "About",
                    controller: value.aboutController,
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    ));
  }
}
