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
      title: 'Opaspun',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter lab 12 ข้อ 2'),
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
  final _formKey = GlobalKey<FormState>();

  late Future<Map<String, dynamic>> apiPost;
  Map<String, dynamic> _mapUsers = {};

  final _nameController = TextEditingController();
  final _jobController = TextEditingController();

  void submitForm() {
    String name = _nameController.text;
    String job = _jobController.text;

    apiPost = apiPostUsers(name, job);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Text(
                      'เพิ่มผู้ใช้',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: "ชื่อ"),
                      onSaved: (newValue) {
                        setState(() {
                          _nameController.text = newValue!;
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'กรุณากรอกชื่อ';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: "อาชีพ"),
                      onSaved: (newValue) {
                        setState(() {
                          _jobController.text = newValue!;
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'กรุณากรอกอาชีพ';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _formKey.currentState!.validate();
                        if (_formKey.currentState!.validate() == true) {
                          _formKey.currentState!.save();
                          submitForm();
                        }
                      },
                      child: Text('บันทึก'),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
