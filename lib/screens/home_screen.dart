import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kiss_list/model/contact_model.dart';
import 'package:kiss_list/screens/edit_add_contct_screen.dart';
import 'package:kiss_list/screens/settings.dart';
import 'package:kiss_list/screens/view_contact_screen.dart';
import 'package:kiss_list/utills/constants.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../providers/contact_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    setState(() {});
    super.initState();

    Provider.of<ContactProvider>(context, listen: false).fetchContactsById();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Consumer<ContactProvider>(builder: (context, value, child) {
        return SingleChildScrollView(
          child: Container(
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
              padding: EdgeInsets.only(
                top: 25,
                left: 20,
                right: 20,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const EditAddContactScreen(),
                            ),
                          );
                        },
                        child: Icon(
                          Icons.person_add_alt,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => const Settings(),
                          //   ),
                          // );
                        },
                        child: Icon(
                          Icons.settings,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    height: 58,
                    width: size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(),
                          Text(
                            "Search",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            Icons.search,
                            color: Colors.black,
                            size: 35,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: size.height / 4 * 3,
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      separatorBuilder: (context, index) => Container(
                        height: 20,
                      ),
                      itemCount: value.contactModel.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ContactCard(
                          size: size,
                          model: value.contactModel[index],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      })),
    );
  }
}

class ContactCard extends StatelessWidget {
  const ContactCard({Key? key, required this.size, required this.model})
      : super(key: key);

  final Size size;
  final ContactModel model;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 400,
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ViewContactScreen()));
        },
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 20),
            Container(
              child: Image.asset(
                Constants.imageAssets('profile.png'),
                fit: BoxFit.fill,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "01",
                  // "$index",
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                Text(
                  model.name.toString(),
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                Icon(
                  Icons.male,
                  color: Colors.black,
                  size: 35,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
