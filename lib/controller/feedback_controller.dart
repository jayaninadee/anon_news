import 'package:get/get.dart';
import 'package:anon_news/db/db_helper.dart';

class FeedbackController extends GetxController {
  RxList<Map<String, dynamic>> feedbacks = <Map<String, dynamic>>[].obs;
  DBHelper dbHelper = DBHelper();

  @override
  void onInit() {
    super.onInit();
    fetchFeedbacks();
  }

  // Fetch all feedbacks
  Future<void> fetchFeedbacks() async {
    final fetchedFeedbacks = await dbHelper.getFeedbacks();
    feedbacks.assignAll(fetchedFeedbacks);
  }

  // Add feedback
  Future<void> addFeedback(String content) async {
    final newFeedback = {
      'content': content,
      'author': 'Anonymous',
    };
    await dbHelper.insertFeedback(newFeedback);
    fetchFeedbacks();
  }

  // Update feedback
  Future<void> updateFeedback(int id, String newContent) async {
    await dbHelper.updateFeedback(id, newContent);
    fetchFeedbacks();
  }

  // Delete feedback
  Future<void> deleteFeedback(int id) async {
    await dbHelper.deleteFeedback(id);
    fetchFeedbacks();
  }
}
