import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Opaspun',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Lab 9 Point 1'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class Student {
  String? name;
  String? age;
  String? tel;

  Student(this.name, this.age, this.tel);
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController telController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  List<Student> stds = [];

  String? temp_name;
  String? temp_age;
  String? temp_tel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              stds.isEmpty
                  ? const Text('No information found',
                      style: TextStyle(fontSize: 22))
                  : const Text('List of students',
                      style: TextStyle(fontSize: 22)),
              Expanded(
                child: ListView.builder(
                    itemCount: stds.length,
                    itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: const Icon(Icons.person),
                            title: Text('Student ${index + 1}'),
                            subtitle: Text(
                                'Name : ${stds[index].name} | Age : ${stds[index].age} | Tel : ${stds[index].tel}'),
                            trailing: SizedBox(
                              width: 60,
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      openDialog(context, id: index);
                                    },
                                    child: const Icon(Icons.create_outlined),
                                  ),
                                  const SizedBox(width: 5),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        stds.removeAt(index);
                                      });
                                      deleteDialog(context);
                                    },
                                    child: const Icon(Icons.delete),
                                  )
                                ],
                              ),
                            ),
                            tileColor: const Color.fromARGB(255, 239, 205, 255),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        )),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => openDialog(context),
        tooltip: 'Add information',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future openDialog(BuildContext context, {int? id}) {
    if (id != null) {
      nameController.text = stds[id].name!;
      ageController.text = stds[id].age!;
      telController.text = stds[id].tel!;
    } else {
      nameController.text = '';
      ageController.text = '';
      telController.text = '';
    }
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: id == null
                  ? const Text('Add data')
                  : Text('Edit data student ${id + 1}'),
              content: SizedBox(
                width: 300,
                height: 300,
                child: Column(
                  children: [
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: nameController,
                              decoration: const InputDecoration(
                                prefixIcon: Align(
                                  widthFactor: 1.0,
                                  heightFactor: 1.0,
                                  child: Icon(
                                    Icons.person_outline,
                                  ),
                                ),
                                labelText: 'Name',
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please fill in information';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              controller: ageController,
                              decoration: const InputDecoration(
                                prefixIcon: Align(
                                  widthFactor: 1.0,
                                  heightFactor: 1.0,
                                  child: Icon(
                                    Icons.access_time,
                                  ),
                                ),
                                labelText: 'Age',
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please fill in information';
                                } else if (RegExp("\d").hasMatch(value)) {
                                  return 'Invalid format.';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              controller: telController,
                              decoration: const InputDecoration(
                                prefixIcon: Align(
                                  widthFactor: 1.0,
                                  heightFactor: 1.0,
                                  child: Icon(
                                    Icons.local_phone,
                                  ),
                                ),
                                labelText: 'Telephone number',
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please fill in information';
                                } else if (RegExp("\d").hasMatch(value)) {
                                  return 'Invalid format.';
                                }
                                return null;
                              },
                            ),
                          ],
                        ))
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.pop(context, 'OK');
                    },
                    child: const Text('Close')),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate() == true) {
                        temp_name = nameController.text;
                        temp_age = ageController.text;
                        temp_tel = telController.text;
                        if (id == null) {
                          setState(() {
                            stds.add(Student(temp_name, temp_age, temp_tel));
                          });
                          Navigator.pop(context, 'OK');
                          notifyDialog(context, id: id);
                        } else {
                          setState(() {
                            stds[id!].name = temp_name;
                            stds[id!].age = temp_age;
                            stds[id!].tel = temp_tel;
                          });
                          Navigator.pop(context, 'OK');
                          notifyDialog(context, id: id);
                        }
                        _formKey.currentState!.reset();
                      }
                    },
                    child: const Text("Submit")),
              ],
            ));
  }

  Future notifyDialog(BuildContext context, {int? id}) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
                title: const Text('Notify'),
                content: id == null
                    ? const Text('Successfully added data.')
                    : const Text('Successfully edited data.'),
                actions: <Widget>[
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context, 'OK');
                      },
                      child: const Text('ok')),
                ]));
  }

  Future deleteDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
                title: const Text('Notify'),
                content: const Text('Successfully deleted data.'),
                actions: <Widget>[
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context, 'OK');
                      },
                      child: const Text('ok')),
                ]));
  }
}
