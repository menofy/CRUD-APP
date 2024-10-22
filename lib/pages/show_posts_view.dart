import 'package:crud_app/core/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ShowPostsView extends StatefulWidget {
  const ShowPostsView({super.key});

  @override
  State<ShowPostsView> createState() => _ShowPostsViewState();
}

class _ShowPostsViewState extends State<ShowPostsView> {
  List<dynamic> posts = [];

  @override
  void initState() {
    super.initState();
    fetchAllPosts();
  }

  Future<void> fetchAllPosts() async {
    final response = await http.get(Uri.https('dummyjson.com', 'posts'));
    if (response.statusCode == 200) {
      setState(() {
        posts = json.decode(response.body)['posts'];
      });
    } else {
      throw Exception('Failed to load posts');
    }
  }

  Future<void> deletePost(int id) async {
    final response =
        await http.delete(Uri.parse('https://dummyjson.com/posts/$id'));
    if (response.statusCode == 200) {
      setState(() {
        posts.removeWhere((post) => post['id'] == id);
      });
    } else {
      throw Exception('Failed to delete post');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'All Posts',
        style: TextStyle(fontSize: 30),
      )),
      body: posts.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return ListTile(
                  title: Text(post['title']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.delete),
                        color: Colors.red,
                        onPressed: () => deletePost(post['id']),
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit),
                        color: Colors.blue,
                        onPressed: () => Navigator.pushNamed(
                            context, RoutesName.update,
                            arguments: post['id']),
                      ),
                      IconButton(
                        icon: const Icon(Icons.remove_red_eye),
                        color: Colors.green,
                        onPressed: () => Navigator.pushNamed(
                            context, RoutesName.getSingle,
                            arguments: post['id']),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
