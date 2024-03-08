import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter lab 12'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //late Future<Map<String, dynamic>> apiusers;
  late Future<List<dynamic>> apiusers;
  List<dynamic> _listUser = [];
  //Map<String, dynamic> _mapUser = {};
  var _apiCalling = false;

  @override
  Widget build(BuildContext context) {
    if (!_apiCalling) {
      apiusers = apiGetUsersList();
      apiusers.then((value) {
        setState(() {
          _listUser.addAll(value);
        });
      });
      _apiCalling = true;
      print("Successfully calling api!");
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _listUser.isEmpty
                ? const Text('No information found',
                    style: TextStyle(fontSize: 22))
                : Expanded(
                    child: ListView.builder(
                        itemCount: _listUser.length,
                        itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                leading: Image.network(
                                    '${_listUser[index]['avatar']}'),
                                title: Text('User ${_listUser[index]['id']}'),
                                subtitle: Text(
                                    'Name : ${_listUser[index]['first_name']} | Lastname : ${_listUser[index]['last_name']}'),
                                trailing: SizedBox(
                                  width: 60,
                                ),
                                tileColor:
                                    const Color.fromARGB(255, 239, 205, 255),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                            )),
                  )
          ],
        ),
      ),
    );
  }
}
