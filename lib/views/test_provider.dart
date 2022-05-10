import 'dart:math';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyModel>(
      create: (context) => MyModel(),
      child: MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: const Text('My App')),
            backgroundColor: Colors.white,
            body: Column(
              children: [
                Builder(
                  builder: (context) {
                    return TextButton(
                      child: const Text('click'),
                      onPressed: () {
                        Provider.of<MyModel>(context, listen: false).doSomething();
                      },
                    );
                  }
                ),
                Container(
                    padding: const EdgeInsets.all(20),
                    color: Colors.green[200],
                    child: Consumer<MyModel>(
                      builder: (context, myModel, child) {
                        return
                          SizedBox(child: Text(myModel.text.toString()));
                      },
                    )),
              ],
            )),
      ),
    );
  }
}

class Button extends StatelessWidget {
  const Button({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: const Text('click'),
      onPressed: () {
        Provider.of<MyModel>(context, listen: false).doSomething();
      },
    );
  }
}

class MyModel with ChangeNotifier {
  int text = 1;
  var items = [];

  MyModel() {
    for (var i = 0; i <= 10; i++) {
      items.add(i);
    }
  }

  void doSomething() {
    text += 1;
    // items[new Random().nextInt(10)] = new Random().nextInt(10);
    notifyListeners();
  }
}
