import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:anon_news/components/news_tile_loading.dart';
import 'package:anon_news/components/trending_loading.dart';
import 'package:anon_news/controller/news_controller.dart';
import 'package:anon_news/pages/home_page/widgets/news_tile.dart';
import 'package:anon_news/pages/home_page/widgets/trending_card.dart';
import 'package:anon_news/pages/new_details/news_details.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    NewsController newsController = Get.put(NewsController());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: const Icon(Icons.dashboard),
                  ),
                  const Text(
                    "ANON NEWS APP",
                    style: TextStyle(
                      fontSize: 25,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.5,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: const Icon(Icons.person),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Hot News",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    "See All",
                    style: Theme.of(context).textTheme.labelSmall,
                  )
                ],
              ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Obx(
                      () => newsController.isTrendingLoading.value
                      ? const Row(
                    children: [
                      TrendingLoadingCard(),
                      TrendingLoadingCard(),
                    ],
                  )
                      : Row(
                    children: newsController.trendingNewsList
                        .map(
                          (e) => TrendingCard(
                        ontap: () {
                          Get.to(NewsDetailsPage(
                            news: e,
                          ));
                        },
                        imageUrl: e.urlToImage!,
                        title: e.title!,
                        author: e.author ?? "Unknown",
                        tag: "Trending no 1",
                        time: e.publishedAt!,
                      ),
                    )
                        .toList(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "News For you",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    "See All",
                    style: Theme.of(context).textTheme.labelSmall,
                  )
                ],
              ),
              const SizedBox(height: 20),
              Obx(
                    () => newsController.isNewsForULoading.value
                    ? Column(
                  children: [
                    NewsTileLoading(),
                    NewsTileLoading(),
                    NewsTileLoading(),
                  ],
                )
                    : Column(
                  children: newsController.newsForYou5
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
              ),

              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Business News",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    "See All",
                    style: Theme.of(context).textTheme.labelSmall,
                  )
                ],
              ),
              const SizedBox(height: 20),
              Obx(
                    () => newsController.isBuisLoading.value
                    ? Column(
                  children: [
                    NewsTileLoading(),
                    NewsTileLoading(),
                    NewsTileLoading(),
                  ],
                )
                    : Column(
                  children: newsController.business5News
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
              ),

              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Tesla News",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    "See All",
                    style: Theme.of(context).textTheme.labelSmall,
                  )
                ],
              ),
              const SizedBox(height: 20),
              Obx(
                    () {
                  if (newsController.isTeslaLoading.value) {
                    return Column(
                      children: [
                        NewsTileLoading(),
                        NewsTileLoading(),
                        NewsTileLoading(),
                      ],
                    );
                  }

                  if (newsController.tesla5News.isEmpty) {
                    return Center(
                      child: Text(
                        "No Tesla news available.",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    );
                  }

                  return Column(
                    children: newsController.tesla5News
                        .map(
                          (e) => NewsTile(
                        ontap: () {
                          Get.to(NewsDetailsPage(news: e));
                        },
                        imageUrl: e.urlToImage ??
                            "https://www.discover-the-world.com/app/uploads/2018/05/canada-alberta-banff-moraine-lake-istk-1440x0-c-default.jpg",
                        title: e.title ?? "No Title",
                        author: e.author ?? "Unknown",
                        time: e.publishedAt ?? "Unknown Date",
                      ),
                    )
                        .toList(),
                  );
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Apple News",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    "See All",
                    style: Theme.of(context).textTheme.labelSmall,
                  )
                ],
              ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Obx(
                      () {
                    if (newsController.isAppleLoading.value) {
                      return Row(
                        children: const [
                          TrendingLoadingCard(),
                          TrendingLoadingCard(),
                        ],
                      );
                    }

                    if (newsController.apple5News.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "No Apple news available.",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      );
                    }

                    return Row(
                      children: newsController.apple5News
                          .map(
                            (e) => TrendingCard(
                          ontap: () {
                            Get.to(NewsDetailsPage(
                              news: e,
                            ));
                          },
                          imageUrl: e.urlToImage ??
                              "https://www.discover-the-world.com/app/uploads/2018/05/canada-alberta-banff-moraine-lake-istk-1440x0-c-default.jpg",
                          title: e.title ?? "No Title Available",
                          author: e.author ?? "Unknown",
                          tag: "Trending News",
                          time: e.publishedAt ?? "Unknown Date",
                        ),
                      )
                          .toList(),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
