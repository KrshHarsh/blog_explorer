import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/blog_bloc.dart';
import '../bloc/blog_event.dart';
import '../bloc/blog_state.dart';
import 'blog_detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BlogListScreen extends StatefulWidget {

@override
State<BlogListScreen> createState() => _BlogListScreenState();
}

class _BlogListScreenState extends State<BlogListScreen> {
@override
void initState() {
context.read<BlogBloc>().add(FetchBlogs());
super.initState();
}
@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: Text('Blog Explorer', style: TextStyle(color: Colors.white)),
actions: [
IconButton(
icon: Icon(Icons.search),
onPressed: () {
// Search functionality can be added here
},
),
],
),
body: BlocBuilder<BlogBloc, BlogState>(
builder: (context, state) {
if (state is BlogLoading) {
return Center(child: CircularProgressIndicator(color: Colors.white));
} else if (state is BlogLoaded) {
return ListView.builder(
itemCount: state.blogs.length,
itemBuilder: (context, index) {
final blog = state.blogs[index];
return Padding(
padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
child: GestureDetector(
onTap: () {
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => BlogDetailScreen(blog: blog),
  ),
);
},
child: Container(
decoration: BoxDecoration(
  color: Color(0xFF1E1E1E),
  borderRadius: BorderRadius.circular(12.0),
),
child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    CachedNetworkImage(
      imageUrl: blog['image_url'] ?? '',
      placeholder: (context, url) => Container(
        height: 200.0,
        color: Colors.grey[800],
      ),
      errorWidget: (context, url, error) => Icon(Icons.error, color: Colors.white),
      height: 200.0,
      width: double.infinity,
      fit: BoxFit.cover,
    ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        blog['title'] ?? 'No title',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ],
),
),
),
);
},
);
} else if (state is BlogError) {
return Center(child: Text(state.message, style: TextStyle(color: Colors.white)));
} else {
return Center(child: Text('Press the button to fetch blogs', style: TextStyle(color: Colors.white)));
}
},
),
floatingActionButton: FloatingActionButton(
onPressed: () {
context.read<BlogBloc>().add(FetchBlogs());
},
backgroundColor: Colors.blueAccent,
child: Icon(Icons.refresh, color: Colors.white),
),
);
}
}
