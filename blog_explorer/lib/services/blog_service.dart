import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';

class BlogService {
final String _url = 'https://intent-kit-16.hasura.app/api/rest/blogs';
final String _adminSecret = '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';

Future<List<dynamic>> fetchBlogs() async {
var box = Hive.box('blogsBox');

try {
final response = await http.get(Uri.parse(_url), headers: {
'x-hasura-admin-secret': _adminSecret,
});

if (response.statusCode == 200) {
// Parse the response and store it in Hive
final List<dynamic> blogs = json.decode(response.body)['blogs'];
await box.put('blogs', blogs);
return blogs;
} else {
// Request failed, return cached data if available
if (box.containsKey('blogs')) {
return box.get('blogs');
} else {
throw Exception('Failed to load blogs');
}
}
} catch (e) {
// On error, return cached data if available
if (box.containsKey('blogs')) {
return box.get('blogs');
} else {
throw Exception('Error fetching blogs: $e');
}
}
}
}
