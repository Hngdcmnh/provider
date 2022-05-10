import 'package:first_project/network/network_request.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/Post.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: ListViewPage());
  }
}

class ListViewPage extends StatefulWidget {
  const ListViewPage({Key? key}) : super(key: key);

  @override
  State<ListViewPage> createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
  List<Post> postData = [];

  @override
  void initState() {
    super.initState();
    NetworkRequest.fetchPosts().then((dataFromServer) {
      setState(() {
        postData = dataFromServer;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('HTTP Request')),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: postData.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            postData[index].title.toString(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(postData[index].body.toString())
                        ],
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}
