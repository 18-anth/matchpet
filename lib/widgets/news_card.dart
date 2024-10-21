import 'package:flutter/material.dart';
import '../models/post.dart';
import '../screens/post_detail_screen.dart';

class NewsCard extends StatelessWidget {
  final Post post;

  NewsCard({required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(post.title),
        subtitle: Text(post.description),
        leading: Image.network(post.imageUrl),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PostDetailScreen(post: post)),
          );
        },
      ),
    );
  }
}
