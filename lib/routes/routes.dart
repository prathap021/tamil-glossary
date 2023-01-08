import 'package:get/get.dart';

import 'package:tamil_glossary/screens/favorite/view.dart';
import 'package:tamil_glossary/screens/homepage/binding.dart';
import 'package:tamil_glossary/screens/words_description/view.dart';

import '../screens/favorite/binding.dart';
import '../screens/homepage/view.dart';
import '../screens/words_description/binding.dart';
import 'pages.dart';

class AppPages {
  static var pages = [
    GetPage(
      name: AppRoutes.home,
      page: () => Homeview(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.words,
      page: () => wordsview(),
      binding: WordsBinding(),
    ),
    GetPage(
      name: AppRoutes.favorite,
      page: () => Favoritewords(),
      binding: FavoriteBinding(),
    ),
  ];
}
