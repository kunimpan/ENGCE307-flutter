import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 8',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Lab 8'),
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

  String? name;
  String? nickName;
  String? tel;
  String? email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Text(
                        'แบบฟอร์ม',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: "ชื่อ - นามสกุล"),
                        onSaved: (newValue) {
                          setState(() {
                            name = newValue;
                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'กรุณากรอกชื่อนามสกุล';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: "ชื่อเล่น"),
                        onSaved: (newValue) {
                          setState(() {
                            nickName = newValue;
                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'กรุณากรอกชื่อเล่น';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: "เบอร์มือถือ"),
                        onSaved: (newValue) {
                          setState(() {
                            email = newValue;
                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'กรุณากรอกเบอร์มือถือ';
                          } else if (!RegExp("[0-9]{10}").hasMatch(value)) {
                            return 'รุปแบบเบอร์มือถือไม่ถูกต้อง';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(labelText: "อีเมล"),
                        onSaved: (newValue) {
                          setState(() {
                            tel = newValue;
                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'กรุณากรอกอีเมล';
                          } else if (!RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                            return 'รุปแบบอีเมลไม่ถูกต้อง';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                _formKey.currentState!.validate();
                                if (_formKey.currentState!.validate() == true) {
                                  _formKey.currentState!.save();
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('ข้อมูล'),
                                          content: SizedBox(
                                            height: 85,
                                            child: Column(
                                              children: [
                                                Text('ชื่อ - นามสกุล : $name'),
                                                Text('ชื่อเล่น : $nickName'),
                                                Text('เบอร์มือถือ : $tel'),
                                                Text('อีเมล : $email'),
                                              ],
                                            ),
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context, 'OK');
                                              },
                                              child: const Text('OK'),
                                            )
                                          ],
                                        );
                                      });
                                }
                              },
                              child: const Text("Submit")),
                          const SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                _formKey.currentState!.reset();
                              },
                              child: const Text("Reset")),
                        ],
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
