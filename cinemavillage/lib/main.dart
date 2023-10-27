import 'package:flutter/material.dart';
import 'package:cinemavillage/screens/signIn_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme:  ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color.fromARGB(255, 25, 25, 25),
        useMaterial3: true,
      ),
      home: const SignInScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
