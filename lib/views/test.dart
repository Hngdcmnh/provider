import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(
        myChild: MyCenterWidget(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final Widget myChild;

  const MyHomePage({required this.myChild}) : super();

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyInheritedWidget(
        child: widget.myChild,
        myData: counter,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            counter++;
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class MyCenterWidget extends StatelessWidget {
  const MyCenterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: MyText(),
    );
  }
}

class MyText extends StatelessWidget {
  const MyText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [ Text('Title'),
        ChildText(),
        Text('kdkđkdkdk')],
    );
  }
}

class ChildText extends StatelessWidget {
  ChildText({
    Key? key,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    final counter = MyInheritedWidget.of(context)?.myData;
    return Text('Number: $counter');
  }
}


class MyInheritedWidget extends InheritedWidget {
  MyInheritedWidget({required Widget child, required this.myData})
      : super(child: child);

  final int myData;

  @override
  bool updateShouldNotify(MyInheritedWidget oldWidget) {
    return myData != oldWidget.myData;
  }

  static MyInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MyInheritedWidget>();
  }
}
