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
      home: const MyHomePage(title: 'ข้อ 1'),
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
  final TextEditingController _nameController = TextEditingController();
  late bool sw1 = false;
  List<String> secOption = ['Sec182', 'Sec307'];

  List<String> abilities = [];

  late String sec = secOption[0];
  late String getText;

  bool isCheckedC = false;
  bool isCheckedCpp = false;
  bool isCheckedPython = false;
  bool isCheckedDart = false;

  String name = 'โปรดระบุข้อมูล';
  String sex = 'โปรดระบุข้อมูล';
  String secRoom = 'โปรดระบุข้อมูล';
  int age = 0;
  String myAbilities = 'โปรดระบุข้อมูล';

  int _ageSilder = 0;

  void _saveData() {
    setState(() {
      sex = (sw1 == true) ? 'หญิง' : 'ชาย';
      secRoom = sec;
      age = _ageSilder;
      name = _nameController.text;
      myAbilities = abilities.join(", ");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 250,
                        child: TextField(
                          controller: _nameController,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            prefixIcon: Align(
                              widthFactor: 1.0,
                              heightFactor: 1.0,
                              child: Icon(
                                Icons.person_outline,
                              ),
                            ),
                            labelText: 'ป้อนชื่อตัวเอง',
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('ชาย'),
                          Switch(
                              value: sw1,
                              onChanged: (value) {
                                setState(() {
                                  sw1 = value;
                                });
                              }),
                          const Text('หญิง')
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                              value: secOption[0],
                              groupValue: sec,
                              onChanged: (value) {
                                setState(() {
                                  sec = value.toString();
                                });
                              }),
                          const Text('Sec182'),
                          const SizedBox(
                            width: 20,
                          ),
                          Radio(
                              value: secOption[1],
                              groupValue: sec,
                              onChanged: (value) {
                                setState(() {
                                  sec = value.toString();
                                });
                              }),
                          const Text('Sec307'),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'อายุ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline),
                      ),
                      Slider(
                          value: _ageSilder.toDouble(),
                          min: 0,
                          max: 100,
                          divisions: 80,
                          label: '$_ageSilder',
                          onChanged: (value) {
                            setState(() {
                              _ageSilder = value.toInt();
                            });
                          }),
                      const Text(
                        'ความถนัดในภาษาคอมพิวเตอร์',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline),
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                checkColor: Colors.amber,
                                value: isCheckedC,
                                onChanged: (value) {
                                  setState(() {
                                    isCheckedC = value!;
                                    isCheckedC == true
                                        ? abilities.add('C')
                                        : abilities.remove('C');
                                  });
                                },
                              ),
                              const Text('C'),
                              Checkbox(
                                checkColor: Colors.amber,
                                value: isCheckedCpp,
                                onChanged: (value) {
                                  setState(() {
                                    isCheckedCpp = value!;
                                    isCheckedCpp == true
                                        ? abilities.add('C++')
                                        : abilities.remove('C++');
                                  });
                                },
                              ),
                              const Text('C++'),
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                checkColor: Colors.amber,
                                value: isCheckedPython,
                                onChanged: (value) {
                                  setState(() {
                                    isCheckedPython = value!;
                                    isCheckedPython == true
                                        ? abilities.add('Python')
                                        : abilities.remove('Python');
                                  });
                                },
                              ),
                              const Text('Python'),
                              Checkbox(
                                checkColor: Colors.amber,
                                value: isCheckedDart,
                                onChanged: (value) {
                                  setState(() {
                                    isCheckedDart = value!;
                                    isCheckedDart == true
                                        ? abilities.add('Dart')
                                        : abilities.remove('Dart');
                                  });
                                },
                              ),
                              const Text('Dart')
                            ],
                          ),
                        ],
                      ),
                      ElevatedButton(
                          onPressed: _saveData,
                          child: const Text(
                            'บันทึก',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      decoration: BoxDecoration(
                        color: Colors.deepPurpleAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        'แสดงผล',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text('ชื่อ - นามสกุล : $name'),
                    Text('เพศ : $sex'),
                    Text('Sec : $secRoom'),
                    Text('อายุ : $age'),
                    Text('ความถนัด : $myAbilities')
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
