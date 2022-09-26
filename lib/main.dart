import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kiss_list/providers/contact_provider.dart';
import 'package:kiss_list/screens/spalsh_screen.dart';
import 'package:kiss_list/screens/view_contact_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => ContactProvider(),
    ),
  ], child: const MyApp()));
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
