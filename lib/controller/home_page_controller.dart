import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:anon_news/components/navigation_bar.dart';
import 'package:anon_news/controller/bottom_navigation_controller.dart';

class HomePageController extends StatelessWidget {
  const HomePageController({super.key});

  @override
  Widget build(BuildContext context) {
    BottomNavController controller = Get.put(BottomNavController());

    return Scaffold(
      floatingActionButton: const MyBottonNav(),
      body: Obx(
        () => controller.pages[controller.index.value],
      ),
    );
  }
}
