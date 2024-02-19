import 'package:flutter/material.dart';

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
      routes: {
        '/': (context) => const MyHomePage(title: 'Flutter Lab 10'),
        '/detail': (context) => DetailPage()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class Characters {
  int? id;
  String? name;
  String? element;
  bool? love;
  String? img;

  Characters(
      {required this.id,
      required this.name,
      required this.element,
      required this.love,
      required this.img});
}

class _MyHomePageState extends State<MyHomePage> {
  List<Characters> charact = [
    Characters(
        id: 1,
        name: "Seele",
        element: "Quantum",
        love: false,
        img: 'assets/images/seele.webp'),
    Characters(
        id: 2,
        name: "Kafka",
        element: "Lightning",
        love: false,
        img: 'assets/images/kafka.webp'),
    Characters(
        id: 3,
        name: "Black Swan",
        element: "Wind",
        love: false,
        img: 'assets/images/black_swan.webp'),
    Characters(
        id: 4,
        name: "Himeko",
        element: "Fire",
        love: false,
        img: 'assets/images/himeko.webp'),
    Characters(
        id: 5,
        name: "Herta",
        element: "Ice",
        love: false,
        img: 'assets/images/herta.webp'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Honkai Star Rail',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: GridView.builder(
                padding: const EdgeInsets.all(10),
                scrollDirection: Axis.vertical,
                itemCount: charact.length,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 180,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemBuilder: (context, index) {
                  return GridTile(
                      //header: Text('Character #${index + 1}'),
                      footer: GridTileBar(
                          backgroundColor: Colors.black38,
                          title: Text('Character #${index + 1}'),
                          subtitle: Column(
                            children: [
                              Text(
                                'Name : ${charact[index].name}',
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                'Element : ${charact[index].element}',
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                          trailing: charact[index].love == false
                              ? const SizedBox(
                                  width: 50,
                                  child: Icon(
                                    Icons.favorite_border,
                                    color: Colors.pink,
                                    size: 30.0,
                                  ),
                                )
                              : const SizedBox(
                                  width: 50,
                                  child: Icon(
                                    Icons.favorite,
                                    color: Colors.pink,
                                    size: 30.0,
                                  ),
                                )),
                      child: InkWell(
                        onTap: () async {
                          var value = await Navigator.pushNamed(
                              context, '/detail',
                              arguments: Characters(
                                  id: index + 1,
                                  name: charact[index].name,
                                  element: charact[index].element,
                                  love: charact[index].love,
                                  img: charact[index].img));
                          value == null
                              ? print('null')
                              : setState(() {
                                  value as List;
                                  charact[value[0] - 1].love = value[3];
                                });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 209, 196, 255),
                              image: DecorationImage(
                                  image: AssetImage('${charact[index].img}'),
                                  fit: BoxFit.cover)),
                        ),
                      ));
                }),
          )
        ],
      ),
    );
  }
}

class DetailPage extends StatefulWidget {
  int? id;
  String? name;
  String? element;
  bool? love;
  String? img;

  DetailPage(
      {super.key, this.id, this.name, this.element, this.love, this.img});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as Characters;

    int id = args.id!;
    String name = args.name!;
    String element = args.element!;
    bool love = args.love!;
    String img = args.img!;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text('${name}'),
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              CircleAvatar(
                radius: 100,
                backgroundImage: AssetImage('${img}'),
              ),
              const SizedBox(
                height: 10,
              ),
              Text('Id : ${id}'),
              Text('Name : ${name}'),
              Text('Element : ${element}'),
              love == false
                  ? ElevatedButton(
                      onPressed: () {
                        setState(() {
                          Navigator.pop(
                              context, [id, name, element, !love, img]);
                        });
                      },
                      child: const Icon(
                        Icons.favorite_border,
                        color: Colors.pink,
                        size: 24.0,
                      ))
                  : ElevatedButton(
                      onPressed: () {
                        setState(() {
                          Navigator.pop(
                              context, [id, name, element, !love, img]);
                        });
                      },
                      child: const Icon(
                        Icons.favorite,
                        color: Colors.pink,
                        size: 24.0,
                      )),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      Navigator.pop(context, [id, name, element, love, img]);
                    });
                  },
                  child: const Text('Home')),
            ],
          ),
        ));
  }
}
