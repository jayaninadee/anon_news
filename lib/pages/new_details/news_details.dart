import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:anon_news/model/news_model.dart';
import 'package:anon_news/controller/news_controller.dart';
import 'package:anon_news/model/comment_model.dart';

class NewsDetailsPage extends StatefulWidget {
  final NewsModel news;
  const NewsDetailsPage({super.key, required this.news});

  @override
  _NewsDetailsPageState createState() => _NewsDetailsPageState();
}

class _NewsDetailsPageState extends State<NewsDetailsPage> {
  final NewsController newsController = Get.put(NewsController());
  final TextEditingController _commentController = TextEditingController();
  List<Comment> comments = []; // Store the list of comments

  // Function to add a new comment
  void _addComment() {
    if (_commentController.text.isNotEmpty) {
      setState(() {
        String commentId = DateTime.now().millisecondsSinceEpoch.toString();
        comments.add(Comment(username: 'Anonymous', content: _commentController.text, id: commentId));
        _commentController.clear(); // Clear the text field after adding comment
      });
    }
  }

  // Function to delete a comment
  void _deleteComment(String commentId) {
    setState(() {
      comments.removeWhere((comment) => comment.id == commentId);
    });
  }

  // Function to update an existing comment
  void _updateComment(String commentId, String newContent) {
    setState(() {
      int index = comments.indexWhere((comment) => comment.id == commentId);
      if (index != -1) {
        comments[index] = Comment(username: 'Anonymous', content: newContent, id: commentId);
      }
    });
  }

  // Function to show a dialog to edit a comment
  void _showEditDialog(Comment comment) {
    _commentController.text = comment.content; // Pre-populate the comment content
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Edit Comment"),
        content: TextField(
          controller: _commentController,
          maxLines: 3,
          decoration: InputDecoration(hintText: 'Update your comment'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              _updateComment(comment.id, _commentController.text);
              Navigator.of(context).pop();
            },
            child: Text("Update"),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("Cancel"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                // News Content Section
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        child: const Row(
                          children: [
                            Icon(Icons.arrow_back_ios_new),
                            Text("Back"),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 30),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            widget.news.urlToImage ?? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQS5_7oSJENwahkO0C1CutE7WjbMZqt6WREQA&s",
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  widget.news.title!,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      "${widget.news.author} * ${widget.news.publishedAt}",
                      style: Theme.of(context).textTheme.labelSmall,
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.red,
                      child: Text(
                        widget.news.author![0],
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      widget.news.author!,
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.secondaryContainer,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Obx(
                            () => newsController.isSpeeking.value
                            ? IconButton(
                          onPressed: () {
                            newsController.stop();
                          },
                          icon: Icon(
                            Icons.stop,
                            size: 50,
                          ),
                        )
                            : IconButton(
                          onPressed: () {
                            newsController.speak(widget.news.description ?? "No Description");
                          },
                          icon: Icon(
                            Icons.play_arrow_rounded,
                            size: 50,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Obx(
                              () => Lottie.asset(
                            'Assets/Animation/wave.json',
                            height: 70,
                            animate: newsController.isSpeeking.value,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        widget.news.description ?? "No Description",
                        style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.secondaryContainer,
                        ),
                      ),
                    ),
                  ],
                ),

                // Comments Section
                const SizedBox(height: 20),
                // Display all the comments
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(), // Disable ListView scrolling
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    final comment = comments[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.grey,
                            child: Text(
                              comment.username[0].toUpperCase(),
                              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                comment.content,
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                          // Edit and delete buttons
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              _showEditDialog(comment); // Show dialog for editing comment
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              _deleteComment(comment.id); // Delete the comment
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),

                // Comment input bar at the bottom
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _commentController,
                          decoration: InputDecoration(
                            hintText: 'Add a comment...',
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: _addComment, // Add comment when pressed
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
