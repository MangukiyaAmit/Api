import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AvatarDemo extends StatefulWidget {
  const AvatarDemo({Key? key}) : super(key: key);

  @override
  State<AvatarDemo> createState() => _AvatarDemoState();
}

class _AvatarDemoState extends State<AvatarDemo> {
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
        'avatar': await dio.MultipartFile.fromFile(image!.path),
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
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  getImage();
                },
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                    child: image == null
                        ? Icon(
                            Icons.camera,
                            size: 70,
                          )
                        : Image.file(image!),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: firstname,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Firstname can not be empty';
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Firstname',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
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
                height: 10,
              ),
              TextFormField(
                controller: username,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'username can not be empty';
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Username',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
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
                onPressed: () {},
                child: Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
