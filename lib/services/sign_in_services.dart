import 'dart:convert';

import 'package:http/http.dart' as http;

class SigninService {
  static Future<bool> signInUser(Map<String, dynamic> reqBody) async {
    http.Response response = await http.post(
      Uri.parse("https://codelineinfotech.com/student_api/User/login.php"),
      body: reqBody,
    );
    var result = jsonDecode(response.body);
    print("-->> ${jsonDecode(response.body)}");
    return result['status'];
  }
}
