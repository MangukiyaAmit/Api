import 'package:flutter/material.dart';

import '../model/example_model.dart';
import '../services/example_service.dart';

class Example extends StatefulWidget {
  const Example({Key? key}) : super(key: key);

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  final username = TextEditingController();
  final password = TextEditingController();

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: formKey,
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
                  if (formKey.currentState!.validate()) {
                    ExampleModel model = ExampleModel();
                    model.username = username.text;
                    model.password = password.text;

                    bool status =
                        await ExampleService.signInUser(model.toJson());

                    if (status == true) {
                      print("Successfully login");
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
