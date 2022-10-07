import 'dart:async';

import 'package:api_post/view/home_page.dart';
import 'package:api_post/view/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? userName;
  @override
  void initState() {
    getUserName().whenComplete(() => Timer(
          Duration(seconds: 2),
          () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  userName == null ? SignupScreen() : HomeScreen(),
            ),
          ),
        ));
    super.initState();
  }

  Future getUserName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final name = preferences.getString('username');
    setState(() {
      userName = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Splash Screen",
          textScaleFactor: 3,
        ),
      ),
    );
  }
}
