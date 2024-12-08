import 'package:get/get.dart';
import 'package:anon_news/pages/artical_page/artical_page.dart';
import 'package:anon_news/pages/home_page/home_page.dart';
import 'package:anon_news/pages/profile/profile_page.dart';

class BottomNavController extends GetxController {
  RxInt index = 0.obs;

  var pages = [
    const HomePage(),
    const ArticalPage(),
    const ProfilePage(),
  ];
}
