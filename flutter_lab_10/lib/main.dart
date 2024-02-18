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
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => MyHomePage(title: 'Flutter Lab 10'),
        '/detail': (context) => DetailPage()
        //name: null, element: null, love: null, img: null
      },
      //home: const MyHomePage(title: 'Flutter Lab 10'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
  //State<MyHomePage> createState2() => DetailPage();
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
  bool? loveStats;
  int _counter = 0;
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

  void _incrementCounter() {
    setState(() {
      _counter++;
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
            Expanded(
              child: GridView.builder(
                  padding: EdgeInsets.all(10),
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
                            subtitle: Text(
                                'Name : ${charact[index].name}\nElement : ${charact[index].element}\nLove : ${charact[index].love}'),
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
                            value as List;

                            setState(() {
                              charact[value[0] - 1].love = value[3];
                            });
                            //print(value!['name']);
                            //loveStats = value.id as bool
                            //charact[loveStats]
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 209, 196, 255),
                                image: DecorationImage(
                                    image: AssetImage('${charact[index].img}'),
                                    fit: BoxFit.cover)),
                          ),
                        ));
                  }),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
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
    setState(() {});
    var args = ModalRoute.of(context)!.settings.arguments as Characters;
    int? id = args.id;
    String? name = args.name;
    String? element = args.element;
    bool? love = args.love;
    String? img = args.img;

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
              Text('Love : ${love}'),
              love == false
                  ? ElevatedButton(
                      onPressed: () {
                        setState(() {
                          Navigator.pop(
                              context, [id, name, element, !love!, img]);
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
                              context, [id, name, element, !love!, img]);
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
