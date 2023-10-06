import 'package:flutter/material.dart';
import 'package:cinemavillage/screens/signIn_screen.dart';
import 'package:cinemavillage/reusable_widgets/bottom_menu_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 241, 81, 37)),
        useMaterial3: true,
      ),
      home: const SignInScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
