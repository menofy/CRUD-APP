import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SinglePostView extends StatefulWidget {
  final int postId;
  const SinglePostView({super.key, required this.postId});

  @override
  State<SinglePostView> createState() => _SinglePostViewState();
}

class _SinglePostViewState extends State<SinglePostView> {
  Map<String, dynamic> post = {};

  @override
  void initState() {
    super.initState();
    fetchSinglePost(widget.postId);
  }

  Future<void> fetchSinglePost(int id) async {
    final response =
        await http.get(Uri.parse('https://dummyjson.com/posts/$id'));
    if (response.statusCode == 200) {
      setState(() {
        post = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load post');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
          'Single Post',
          style: TextStyle(fontSize: 30),
        )),
        body: post.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(post['title'], style: const TextStyle(fontSize: 24)),
                    const SizedBox(height: 16),
                    Text(post['body'], style: const TextStyle(fontSize: 22)),
                  ],
                ),
              ));
  }
}
