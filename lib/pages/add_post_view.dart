import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddPostView extends StatefulWidget {
  const AddPostView({super.key});

  @override
  State<AddPostView> createState() => _AddPostViewState();
}

class _AddPostViewState extends State<AddPostView> {
  final _titleController = TextEditingController();

  Future<void> createPost() async {
    final response = await http.post(
      Uri.parse('https://dummyjson.com/posts/add'),
      headers: {"Content-Type": "application/json"},
      body: json.encode({'title': _titleController.text, 'userId': 5}),
    );
    if (response.statusCode == 201) {
      _titleController.clear();
      print(response.body);
    } else {
      throw Exception('Failed to create post');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'Add Post',
        style: TextStyle(fontSize: 30),
      )),
      body:
      
       Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Title',
                  labelStyle: TextStyle(fontSize: 30)),
                  
            ),
            const SizedBox(height: 20),
            MaterialButton(
              color: Colors.red,
              textColor: Colors.white,
              onPressed: () {
                createPost();
              },
              child: const Text(
                'Create Post',
                style: TextStyle(fontSize: 22),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
