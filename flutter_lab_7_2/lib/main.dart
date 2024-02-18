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
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'ข้อ 2'),
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
  final TextEditingController _centimeterController = TextEditingController();
  final TextEditingController _inchesController = TextEditingController();

  double centimeter = 0.00;
  double inches = 0.00;
  String inchesResult = '';

  void _convertValue() {
    setState(() {
      centimeter = double.parse(_centimeterController.text);
      inches = centimeter / 2.54;
      inchesResult = '${inches.toStringAsFixed(2)} inch';
      _inchesController.text = inchesResult;
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
            SizedBox(
              width: 300,
              child: TextField(
                controller: _centimeterController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    suffixText: 'cm',
                    labelText: 'Enter Centimeter',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)))),
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_down,
              size: 30,
            ),
            SizedBox(
              width: 300,
              child: TextField(
                textAlign: TextAlign.center,
                controller: _inchesController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)))),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () {
                  _convertValue();
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Alert'),
                          content: const Text('เปลี่ยนแปลงค่าสำเร็จ'),
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
                },
                child: const Text(
                  'แปลงค่า',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
    );
  }
}
