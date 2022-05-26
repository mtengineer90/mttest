import 'package:flutter/material.dart';
import 'package:mttest/login.dart';
import 'package:firebase_core/firebase_core.dart';

import 'location.dart';
import 'register.dart';

/* void main() {
  runApp(const MyApp());
} */
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EZKA Test',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(

        primarySwatch: Colors.blue,
        bottomSheetTheme: BottomSheetThemeData(
            backgroundColor: Colors.transparent),

      ),
      home: const RegisterPage(title: 'EZKA TEST'),
    );
  }
}
