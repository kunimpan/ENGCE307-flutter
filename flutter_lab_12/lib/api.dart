import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<dynamic>> apiGetUsersList() async {
  var url = "https://reqres.in/api/users";
  var uri = Uri.parse(url);
  var response = await http.get(uri);

  if (response.statusCode == 200) {
    print("Request Success!!");
    var list = jsonDecode(response.body);
    var listRange = list['data'].getRange(0, 6).toList();
    return listRange;
  } else {
    throw Exception('Request failed!: ${response.statusCode}');
  }
}

Future<Map<String, dynamic>> apiPostUsers(String name, String job) async {
  var url = "https://reqres.in/api/users";
  var uri = Uri.parse(url);
  var response = await http.get(uri);

  if (response.statusCode == 201) {
    print("Request Success!");
    return jsonDecode(response.body) as Map<String, dynamic>;
  } else {
    throw Exception('Request failed!: ${response.statusCode}');
  }
}

Future<Map<String, dynamic>> apiGetUsers() async {
  var url = "https://jsonplaceholder.typicode.com/todos/1";
  var uri = Uri.parse(url);
  var response = await http.get(uri);

  if (response.statusCode == 200) {
    print("Request Success!");
    return jsonDecode(response.body) as Map<String, dynamic>;
  } else {
    throw Exception('Request failed!: ${response.statusCode}');
  }
}

/*
Future<List<dynamic>> apiGetUsersList() async {
  var url = "https://jsonplaceholder.typicode.com/todos";
  //var url = "https://reqres.in/api/users";
  var uri = Uri.parse(url);
  var response = await http.get(uri);

  if (response.statusCode == 200) {
    print("Request Success!!");
    print(response.body);
    var list = jsonDecode(response.body) as List<dynamic>;
    var listRange = list.getRange(0, 10).toList();

    return listRange;
  } else {
    throw Exception('Request failed!: ${response.statusCode}');
  }
}
*/


