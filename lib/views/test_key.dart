import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  var listTile = <Widget>[

    // Padding(
    //   key: UniqueKey(),
    //   padding: const EdgeInsets.all(8.0),
    //   child: Tile(),
    // ),
    // Padding(
    //   key: UniqueKey(),
    //   padding: const EdgeInsets.all(8.0),
    //   child: Tile(),
    // ),
    // SizedBox(
    //   key: UniqueKey(),
    //   child: Text('kdkdkd'),
    // )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          children: listTile,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: swapTwoTileWidget,
        child: Icon(Icons.swap_horiz),
      ),
    );
  }

  void swapTwoTileWidget() {
    setState(() {
      listTile.insert(1, listTile.removeAt(0));
    });
  }
}

class SLTile extends StatelessWidget {
  const SLTile({Key? key, required this.getColor}) : super(key: key);
  final Color Function() getColor;


  @override
  Widget build(BuildContext context) {
    return Container(
      color: getColor(),
      height: 100,
      width: 100,
    );
  }
}


class Tile extends StatefulWidget {

  const Tile({Key? key}) : super(key: key);
  @override
  _TileState createState() => _TileState();
}

class _TileState extends State<Tile> {
  final Color color = generateRandomColor();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      width: 100,
      height: 100,
    );
  }
}

Color generateRandomColor() {
  final Random random = Random();
  return Color.fromRGBO(
      random.nextInt(255), random.nextInt(255), random.nextInt(255), 1);
}
