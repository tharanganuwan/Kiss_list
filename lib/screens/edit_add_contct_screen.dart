import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kiss_list/components/custom_button.dart';
import 'package:kiss_list/components/custom_textFeild.dart';
import 'package:kiss_list/providers/contact_provider.dart';
import 'package:kiss_list/screens/home_screen.dart';
import 'package:kiss_list/utills/constants.dart';
import 'package:kiss_list/widget/widget.dart';
import 'package:provider/provider.dart';

class EditAddContactScreen extends StatefulWidget {
  const EditAddContactScreen({Key? key}) : super(key: key);

  @override
  State<EditAddContactScreen> createState() => _EditAddContactScreenState();
}

class _EditAddContactScreenState extends State<EditAddContactScreen> {
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
                            GestureDetector(
                              onTap: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => const HomeScreen(),
                                //   ),
                                // );
                              },
                              child: Icon(
                                Icons.save_outlined,
                                color: Color.fromARGB(255, 0, 0, 0),
                                size: 35,
                              ),
                            ),
                            Icon(
                              Icons.delete_outlined,
                              color: Color.fromARGB(255, 0, 0, 0),
                              size: 35,
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
                                  text: "Kamal Kamal",
                                  width: 250,
                                ),
                                RightContaner(
                                  text: "X/10",
                                  width: 95,
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                LeftContaner(
                                  text: "Gender : ♂",
                                  width: 200,
                                ),
                                SizedBox(width: 10),
                                CenterContaner(
                                  text: "Age : 18",
                                  width: 140,
                                )
                              ],
                            ),
                            SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(),
                                CenterContaner(
                                  text: "Add date",
                                  width: 180,
                                ),
                                RightContaner(
                                  text: "Add ratin",
                                  width: 145,
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(),
                                LeftContaner(
                                  text: "Add Notices",
                                  height: 110,
                                  width: size.width - 150,
                                ),
                                RightContaner(
                                  height: 110,
                                  text: "Delete",
                                  width: 145,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            CenterContaner(text: "Add Another", width: 300)
                          ],
                        ),
                      )
                    ],
                  ),
                  BottomContaner(
                      height: 120,
                      width: size.width - 10,
                      text: "Hear can come notes about this peron general"),
                ],
              ),
            ),
            Column(
              children: [
                CustomTextFeild(
                  controller: value.nameController,
                  hint: 'name',
                ),
                CustomTextFeild(
                    controller: value.genderController, hint: 'gender'),
                CustomTextFeild(
                  controller: value.ageController,
                  hint: 'age',
                ),
                CustomTextFeild(
                  controller: value.dateController,
                  hint: 'date',
                ),
                CustomTextFeild(
                  controller: value.aboutController,
                  hint: 'about',
                ),
                CustomTextFeild(
                  controller: value.noticesController,
                  hint: 'notices',
                ),
                CustomTextFeild(
                  controller: value.ratingController,
                  hint: 'rating',
                ),
                CustomButton(
                    name: "submit",
                    onPress: () {
                      value.startAddContactDetails(context);
                    })
              ],
            )
          ],
        );
      }),
    ));
  }
}
