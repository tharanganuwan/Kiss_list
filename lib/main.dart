import 'package:flutter/material.dart';
import 'package:kiss_list/screens/spalsh_screen.dart';
import 'package:kiss_list/screens/view_contact_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kiss list',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: const ViewContactScreen()
      home: SpalshScrren(),
    );
  }
}
