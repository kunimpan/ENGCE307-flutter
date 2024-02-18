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
      home: const MyHomePage(title: 'Flutter Lab 9 Point 2'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class Product {
  String? name;
  double? price;

  Product(this.name, this.price);
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  List<Product> prods = [];

  String? temp_name;
  double? temp_price;

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
              prods.isEmpty
                  ? const Text('No product found',
                      style: TextStyle(fontSize: 22))
                  : const Text('List of products',
                      style: TextStyle(fontSize: 22)),
              const SizedBox(height: 10),
              Expanded(
                child: GridView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: prods.length,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 300,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20),
                    itemBuilder: (context, index) {
                      return GridTile(
                        child: Container(
                          color: const Color.fromARGB(255, 239, 205, 255),
                        ),
                        header: Text('Product #${index + 1}'),
                        footer: GridTileBar(
                          backgroundColor: Colors.black38,
                          title: Text('Product #${index + 1}'),
                          subtitle: Text(
                              'Name : ${prods[index].name}\nPrice : ${prods[index].price}'),
                          trailing: SizedBox(
                            width: 50,
                            child: Row(
                              children: [
                                InkWell(
                                    onTap: () {
                                      openDialog(context, id: index);
                                    },
                                    child: const Icon(Icons.create_outlined)),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      prods.removeAt(index);
                                    });
                                    deleteDialog(context);
                                  },
                                  child: const Icon(Icons.delete),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => openDialog(context),
        tooltip: 'Add product',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future openDialog(BuildContext context, {int? id}) {
    if (id != null) {
      nameController.text = prods[id].name!;
      priceController.text = (prods[id].price!).toString();
    } else {
      nameController.text = '';
      priceController.text = '';
    }
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: id == null
                  ? const Text('Add product')
                  : Text('Edit Product ${id + 1}'),
              content: SizedBox(
                width: 300,
                height: 200,
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
                                    Icons.shopping_cart_outlined,
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
                              controller: priceController,
                              decoration: const InputDecoration(
                                prefixIcon: Align(
                                  widthFactor: 1.0,
                                  heightFactor: 1.0,
                                  child: Icon(
                                    Icons.price_change_outlined,
                                  ),
                                ),
                                labelText: 'Price',
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
                        temp_price = double.parse(priceController.text);
                        if (id == null) {
                          setState(() {
                            prods.add(Product(temp_name, temp_price));
                          });
                          Navigator.pop(context, 'OK');
                          notifyDialog(context, id: id);
                        } else {
                          setState(() {
                            prods[id!].name = temp_name;
                            prods[id!].price = temp_price;
                          });
                          Navigator.pop(context, 'OK');
                          notifyDialog(context, id: id);
                        }
                        print(prods[0].name);
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
                    ? const Text('Successfully added product.')
                    : const Text('Successfully edited product.'),
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
                content: const Text('Successfully deleted product.'),
                actions: <Widget>[
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context, 'OK');
                      },
                      child: const Text('ok')),
                ]));
  }
}
