import 'dart:convert';

import 'package:http/http.dart' as http;

class DeleteUserService {
  static Future deleteUser(Map<String, dynamic> reqBody) async {
    http.Response response = await http.post(
        Uri.parse(
            'https://codelineinfotech.com/student_api/User/delete_user.php'),
        body: reqBody);

    var result = jsonDecode(response.body);
    print('Delete User==>>${jsonDecode(response.body)}');
    return result;
  }
}
