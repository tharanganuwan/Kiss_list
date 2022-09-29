import 'package:flutter/material.dart';
import 'package:kiss_list/controllers/contact_controller.dart';
import 'package:kiss_list/model/contact_model.dart';
import 'package:kiss_list/screens/edit_add_contct_screen.dart';
import 'package:kiss_list/screens/view_contact_screen.dart';
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

    // Provider.of<ContactProvider>(context, listen: false).fetchContactsById();
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
                              builder: (context) => EditAddContactScreen(),
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
                          SizedBox(
                            width: 200,
                            child: TextField(
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                //prefixIcon: widget,
                                fillColor: Colors.white,
                                filled: true,
                                hintText: "Search",
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(15)),
                                // focusedBorder: OutlineInputBorder(
                                //     borderSide: BorderSide(color: Colors.black),
                                //     borderRadius: BorderRadius.circular(15)),
                              ),
                            ),
                          ),
                          // Text(
                          //   "Search",
                          //   style: TextStyle(
                          //     fontSize: 25,
                          //     fontWeight: FontWeight.bold,
                          //   ),
                          // ),
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
                    // child: ListView.separated(
                    //   physics: BouncingScrollPhysics(),
                    //   separatorBuilder: (context, index) => Container(
                    //     height: 20,
                    //   ),
                    //   itemCount: value.contactModel.length,
                    //   itemBuilder: (BuildContext context, int index) {
                    //     return ContactCard(
                    //       size: size,
                    //       model: value.contactModel[index],
                    //     );
                    //   },
                    // ),
                    child: StreamBuilder(
                      stream: ContactController().getAContactFromFirebase(),
                      builder: (context,
                          AsyncSnapshot<List<ContactModel>> snapshot) {
                        // print("-------------");
                        // print(snapshot.data!.length);
                        // print("-------------");

                        if (snapshot.hasData) {
                          return ListView.separated(
                            separatorBuilder: (context, index) => Container(
                              height: 20,
                            ),
                            physics: const BouncingScrollPhysics(),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return ContactCard(
                                size: size,
                                model: snapshot.data![index],
                                num: index,
                              );
                            },
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text('Error fetching data: ' +
                                snapshot.error.toString()),
                          );
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
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
  const ContactCard({
    Key? key,
    required this.size,
    required this.model,
    required this.num,
  }) : super(key: key);

  final Size size;
  final int num;
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
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ViewContactScreen(
                        contactModel: model,
                      )));
        },
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 20),
            Container(
              height: 300,
              child: Image.network(fit: BoxFit.cover, model.img.toString()),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  (num + 1).toString(),
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
