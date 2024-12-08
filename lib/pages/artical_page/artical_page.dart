import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:anon_news/controller/news_controller.dart';
import 'package:anon_news/pages/artical_page/widgets/search_widget.dart';
import 'package:anon_news/pages/new_details/news_details.dart';

import 'package:anon_news/pages/home_page/widgets/news_tile.dart';


class ArticalPage extends StatelessWidget {
  const ArticalPage({super.key});

  @override
  Widget build(BuildContext context) {
    NewsController newsController = Get.put(NewsController());
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              SearchWidget(),
              SizedBox(height: 20),
              Obx(
                    () => Column(
                  children: newsController.newsForYouList
                      .map(
                        (e) => NewsTile(
                      ontap: () {
                        Get.to(NewsDetailsPage(news: e));
                      },
                      imageUrl: e.urlToImage ??
                          "https://www.discover-the-world.com/app/uploads/2018/05/canada-alberta-banff-moraine-lake-istk-1440x0-c-default.jpg",
                      title: e.title!,
                      author: e.author ?? "Unknown",
                      time: e.publishedAt!,
                    ),
                  )
                      .toList(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
