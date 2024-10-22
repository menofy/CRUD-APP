import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditPostView extends StatefulWidget {
  final int postId;
  const EditPostView({super.key, required this.postId});

  @override
  State<EditPostView> createState() => _EditPostViewState();
}

class _EditPostViewState extends State<EditPostView> {
  final _titleController = TextEditingController();

  Future<void> updatePost(int id) async {
    final response = await http.put(
      Uri.parse('https://dummyjson.com/posts/$id'),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        'title': _titleController.text,
      }),
    );
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      throw Exception('Failed to update post');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Update Post', style: TextStyle(fontSize: 30))),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                  labelStyle: TextStyle(fontSize: 30),
                  labelText: 'Title',
                  border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            MaterialButton(
              color: Colors.red,
              textColor: Colors.white,
              onPressed: () => updatePost(widget.postId),
              child: const Text('Update Post', style: TextStyle(fontSize: 22)),
            ),
          ],
        ),
      ),
    );
  }
}
