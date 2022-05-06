import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: PositionedKey(),
    );
  }
}

class PositionedKey extends StatefulWidget {
  const PositionedKey({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PositionedKeyState();
}
class PositionedKeyState extends State<PositionedKey> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: Text('kdkdkdkdk'),
    ),);
  }

}