import 'package:api_post/model/all_user_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<AllUserModel> getData() async {
    http.Response response = await http.get(
      Uri.parse("https://codelineinfotech.com/student_api/User/allusers.php"),
    );
    return allUserModelFromJson(response.body);
  }
}
