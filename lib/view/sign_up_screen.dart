import 'dart:io';

import 'package:api_post/view/home_page.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/sign_up_model.dart';
import '../services/sign_Up_service.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final firstname = TextEditingController();
  final lastname = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();

  final formKey = GlobalKey<FormState>();
  ImagePicker picker = ImagePicker();
  File? image;

  void getImage() async {
    final file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      setState(() {
        image = File(file.path);
      });
    }
  }

  Future uploadUserImage() async {
    dio.FormData formData = dio.FormData.fromMap(
      {
        'avatar':
            await dio.MultipartFile.fromFile(image!.path, filename: 'demo')
      },
    );

    dio.Response response = await dio.Dio().post(
        'https://codelineinfotech.com/student_api/User/user_avatar_upload.php',
        data: formData);

    if (response.data['url'] != null) {
      return response.data['url'];
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  getImage();
                },
                child: Container(
                    height: 170,
                    width: 170,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300, shape: BoxShape.circle),
                    child: ClipOval(
                      child: image == null
                          ? Icon(
                              Icons.camera,
                              size: 50,
                            )
                          : Image.file(
                              image!,
                              fit: BoxFit.cover,
                            ),
                    )),
              ),
              TextFormField(
                textInputAction: TextInputAction.next,
                controller: firstname,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Firstname can not be empty';
                  }
                },
                decoration: InputDecoration(hintText: 'Firstname'),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                textInputAction: TextInputAction.next,
                controller: lastname,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Lastname can not be empty';
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Lastname',
                ),
              ),
              SizedBox(
                height: 20,
              ),
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
                  // SignupService.postData(
                  //   firstname: firstname.text,
                  //   lastname: lastname.text,
                  //   username: username.text,
                  //   password: password.text,
                  // );
                  if (formKey.currentState!.validate()) {
                    String url = await uploadUserImage();
                    SignUpModel model = SignUpModel();
                    model.firstName = firstname.text;
                    model.lastName = lastname.text;
                    model.username = username.text;
                    model.password = password.text;
                    model.avatar = url;
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    bool status =
                        await SignupService.signUpWithModel(model.toJson());

                    if (status == true) {
                      prefs.setString('username', username.text);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("User already exists."),
                        ),
                      );
                    }
                  }
                },
                child: Text(
                  'Sign Up',
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
