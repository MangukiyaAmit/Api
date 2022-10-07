import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/sign_in_model.dart';
import '../services/sign_in_services.dart';
import 'example.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final username = TextEditingController();
  final password = TextEditingController();

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                textInputAction: TextInputAction.next,
                controller: username,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Username can not be empty';
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Username',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                textInputAction: TextInputAction.next,
                controller: password,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Password can not be empty';
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Password',
                ),
              ),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (formkey.currentState!.validate()) {
                    SignInModel model = SignInModel();
                    model.username = username.text;
                    model.password = password.text;
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    bool status =
                        await SigninService.signInUser(model.toJson());

                    if (status == true) {
                      prefs.setString('username', username.text);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Example(),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Invalid username or password"),
                        ),
                      );
                    }
                  }
                },
                child: Text(
                  'Sign In',
                  style: TextStyle(fontSize: 20),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
