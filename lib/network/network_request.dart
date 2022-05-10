import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import '../model/Post.dart';
import 'package:http/http.dart' as http;

class NetworkRequest {
  static const String url = 'https://jsonplaceholder.typicode.com/posts';

  static List<Post> parsePost(String responseBody)
  {
    var list = json.decode(responseBody) as List<dynamic>;
    List<Post> posts = list.map((model) => Post.fromJson(model)).toList();
    return posts;
  }

  static Future<List<Post>> fetchPosts({int page =1}) async{
    log('start');
    final response = await http.get(Uri.parse(url));
    log('end');
    if(response.statusCode ==200){
      return compute(parsePost, response.body);
    }
    else if(response.statusCode ==404)
      {
        throw Exception('Not Found');
      }
    else{
      throw Exception('Can\'t get post');
    }

  }
}

