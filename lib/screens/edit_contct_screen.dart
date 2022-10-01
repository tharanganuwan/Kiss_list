import 'dart:ui';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:kiss_list/components/custom_dialog.dart';
import 'package:kiss_list/controllers/contact_controller.dart';
import 'package:kiss_list/model/contact_model.dart';
import 'package:kiss_list/providers/contact_provider.dart';
import 'package:kiss_list/screens/home_screen.dart';
import 'package:kiss_list/utills/util_functions.dart';
import 'package:kiss_list/widget/widget.dart';
import 'package:provider/provider.dart';

class EditContactScreen extends StatefulWidget {
  EditContactScreen({
    Key? key,
    required this.contactModel,
  }) : super(key: key);
  final ContactModel contactModel;
  @override
  State<EditContactScreen> createState() => _EditContactScreenState();
}

const List<String> list = <String>['Male  ♂', 'Female  ♀', 'Other  ♂♀'];

class _EditContactScreenState extends State<EditContactScreen> {
  String dropdownValue = list.first;
  @override
  void initState() {
    Provider.of<ContactProvider>(context, listen: false)
        .setControllers(widget.contactModel);
    // TODO: implement initState
    super.initState();
  }

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
                            : (widget.contactModel.img == null)
                                ? Image.asset(
                                    "assets/images/profile.png",
                                    fit: BoxFit.fill,
                                  )
                                : Image.network(
                                    widget.contactModel.img.toString(),
                                    fit: BoxFit.fill,
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
                                  value.updateContact(
                                      context, widget.contactModel.id);
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
                                  ContactController()
                                      .deleteContact(widget.contactModel.id)
                                      .whenComplete(() {
                                    CustomAwesomDialog().dialogBox(
                                        context,
                                        "Success...!",
                                        "Congratulations...! Successfully Deleted.",
                                        DialogType.SUCCES);

                                    Future.delayed(Duration(seconds: 5), () {
                                      UtilFunctions.pushRemoveNavigator(
                                          context, HomeScreen());
                                    });
                                  });
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
                                  text: widget.contactModel.name.toString(),
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
                                      value: value.genderController.text
                                          .toString(),
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
                                //   text: widget.contactModel.gender.toString(),
                                //   width: 200,
                                //   controller: value.genderController,
                                // ),
                                SizedBox(width: 10),
                                CenterContaner(
                                  text: widget.contactModel.age.toString(),
                                  width: 140,
                                  controller: value.ageController,
                                )
                              ],
                            ),
                            SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(),
                                CenterContaner(
                                  text: widget.contactModel.date.toString(),
                                  width: 180,
                                  controller: value.dateController,
                                ),
                                RightContaner(
                                  text: widget.contactModel.rating.toString(),
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
                                  text: widget.contactModel.notices.toString(),
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
                                        //value.deleteContactDetails(context);
                                        ContactController()
                                            .deleteContact(
                                                widget.contactModel.id)
                                            .whenComplete(() {
                                          CustomAwesomDialog().dialogBox(
                                              context,
                                              "Success...!",
                                              "Congratulations...! Successfully Deleted.",
                                              DialogType.SUCCES);

                                          Future.delayed(Duration(seconds: 5),
                                              () {
                                            UtilFunctions.pushRemoveNavigator(
                                                context, HomeScreen());
                                          });
                                        });
                                        ;
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
                                value.cleardata();
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
                    text: widget.contactModel.about.toString(),
                    controller: value.aboutController,
                  ),
                ],
              ),
            ),
            // Column(
            //   children: [
            //     CustomTextFeild(
            //       controller: value.nameController,
            //       hint: 'name',
            //     ),
            //     CustomTextFeild(
            //         controller: value.genderController, hint: 'gender'),
            //     CustomTextFeild(
            //       controller: value.ageController,
            //       hint: 'age',
            //     ),
            //     CustomTextFeild(
            //       controller: value.dateController,
            //       hint: 'date',
            //     ),
            //     CustomTextFeild(
            //       controller: value.aboutController,
            //       hint: 'about',
            //     ),
            //     CustomTextFeild(
            //       controller: value.noticesController,
            //       hint: 'notices',
            //     ),
            //     CustomTextFeild(
            //       controller: value.ratingController,
            //       hint: 'rating',
            //     ),
            //     CustomButton(
            //         name: "submit",
            //         onPress: () {
            //           value.startAddContactDetails(context);
            //         })
            //   ],
            // )
          ],
        );
      }),
    ));
  }
}
