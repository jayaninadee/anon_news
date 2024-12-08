import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

//  TextEditingController _feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('About Us'),
        backgroundColor: Colors.blueAccent,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Padding(
            padding: EdgeInsets.all(8.0), // Adjust padding
            child: Icon(Icons.arrow_back),
          ),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // About Section
          ListTile(
            title: const Text('About App'),
            subtitle: const Text('Learn more about this app'),
            trailing: const Icon(Icons.info),
            onTap: () {
              _showAboutDialog(context);
            },
          ),
          const Divider(),

          // Feedback Section
          ListTile(
            title: const Text('Send Feedback'),
            subtitle: const Text('Send us feedback or report a bug'),
            trailing: const Icon(Icons.feedback),
            onTap: () {
              _showFeedbackDialog(context);
            },
          ),
          const Divider(),
        ],
      ),
    );
  }

  // Function to show About Dialog
  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('About This App'),
          content: const Text(
            'This is a news app that provides the latest updates from various sources. Built with Flutter.\n\n'
            'Version: 1.0.0\n\n'
            'Developed by: P.Jayani N. Silva @ ANONLABZ',
            style: TextStyle(fontSize: 16),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  // Function to show Feedback Form Dialog
  void _showFeedbackDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Send Feedback'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Please provide your feedback or bug report:'),
              const SizedBox(height: 10),
              TextField(
                // controller: _feedbackController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Write your feedback...',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                // String feedback = _feedbackController.text.trim();
                // if (feedback.isNotEmpty) {
                // await _sendFeedback(feedback);
                // }
                Navigator.of(context).pop();
              },
              child: const Text('Send'),
            ),
          ],
        );
      },
    );
  }

  //  send feedback
  Future<void> _sendFeedback(String feedback) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'info@anonlabz.com',
      queryParameters: {
        'subject': 'User Feedback',
        'body': feedback,
      },
    );
  }
}
