import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BlogDetailScreen extends StatelessWidget {
final dynamic blog;

const BlogDetailScreen({Key? key, required this.blog}) : super(key: key);

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: Text(blog['title'] ?? 'Blog Detail', style: TextStyle(color: Colors.white)),
),
body: SingleChildScrollView(
child: Padding(
padding: const EdgeInsets.all(16.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
CachedNetworkImage(
imageUrl: blog['image_url'] ?? '',
placeholder: (context, url) => Container(
height: 250.0,
color: Colors.grey[800],
),
errorWidget: (context, url, error) => Icon(Icons.error, color: Colors.white),
height: 250.0,
width: double.infinity,
fit: BoxFit.cover,
),
SizedBox(height: 16),
Text(
blog['title'] ?? 'No title',
style: TextStyle(
color: Colors.white,
fontSize: 24,
fontWeight: FontWeight.bold,
),
),
SizedBox(height: 16),
Text(
blog['content'] ?? 'No content',
style: TextStyle(color: Colors.white70, fontSize: 16),
),
],
),
),
),
);
}
}
