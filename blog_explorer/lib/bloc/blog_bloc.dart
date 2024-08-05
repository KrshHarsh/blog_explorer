import 'package:blog_explorer/services/blog_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blog_event.dart';
import 'blog_state.dart';


class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final BlogService blogService;

  BlogBloc({required this.blogService}) : super(BlogInitial()) {
    on<FetchBlogs>((event, emit) async {
      emit(BlogLoading());
      try {
        final blogs = await blogService.fetchBlogs();
        emit(BlogLoaded(blogs));
      } catch (e) {
        emit(BlogError('Failed to fetch blogs'));
      }
    });
  }
}
