import 'dart:convert';

import 'package:api/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<SamplePost> samplePost = [];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: samplePost.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 130,
                    color: Colors.green,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'User Id: ${samplePost[index].userId} ',
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          'Id: ${samplePost[index].id}  ',
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          'Title:${samplePost[index].title} ',
                          maxLines: 1,
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          'Body: ${samplePost[index].body}  ',
                          maxLines: 1,
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  );
                });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Future<List<SamplePost>> getData() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        samplePost.add(SamplePost.fromJson(index));
      }
      return samplePost;
    } else {
      return samplePost;
    }
  }
}
