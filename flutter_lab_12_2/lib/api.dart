import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> apiPostUsers(String name, String job) async {
  var url = "https://reqres.in/api/users";
  var uri = Uri.parse(url);
  var response = await http.post(uri,
      headers: <String, String>{'content-type': 'application/json'},
      body: jsonEncode(<String, dynamic>{"name": name, "job": job}));

  if (response.statusCode == 201) {
    print("Post Success! : ${response.statusCode}");
    print("data : ${response.body}");
    return jsonDecode(response.body) as Map<String, dynamic>;
  } else {
    throw Exception('Request failed!: ${response.statusCode}');
  }
}
