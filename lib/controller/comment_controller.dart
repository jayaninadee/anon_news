import 'package:get/get.dart';
import 'package:anon_news/model/comment_model.dart';

class CommentController extends GetxController {
  // Observable list of comments
  var comments = <Comment>[].obs;

  // Add a comment
  void addComment(String content) {
    final comment = Comment(
        username: 'Anonymous',
        content: content,
        id: DateTime.now().millisecondsSinceEpoch.toString());
    comments.add(comment);
  }

  // Delete a comment
  void deleteComment(String id) {
    comments.removeWhere((comment) => comment.id == id);
  }

  // Update a comment
  void updateComment(String id, String newContent) {
    int index = comments.indexWhere((comment) => comment.id == id);
    if (index != -1) {
      comments[index] = Comment(username: 'Anonymous', content: newContent, id: id);
    }
  }
}