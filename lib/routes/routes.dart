import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tamil_glossary/screens/Description/description_view.dart';

import 'package:tamil_glossary/screens/favorite/favourite_view.dart';
import 'package:tamil_glossary/screens/homepage/homepage_binding.dart';
import 'package:tamil_glossary/screens/splash/splash_view.dart';

import '../screens/auth/login/login_view.dart';

import '../screens/favorite/favourite_binding.dart';
import '../screens/homepage/homepage_view.dart';

import 'pages.dart';

class AppPages {
  static var pages = [
    GetPage(
      transition: Transition.fadeIn,
      name: AppRoutes.home,
      page: () => Homeview(),
      binding: HomeBinding(),
    ),
    GetPage(
      transition: Transition.fadeIn,
      name: AppRoutes.wordsDescription,
      page: () => DescriptionView(),
      // binding: WordsBinding(),
    ),
    // wordsview()
    GetPage(
      transition: Transition.fadeIn,
      name: AppRoutes.favorite,
      page: () => Favoritewords(),
      binding: FavoriteBinding(),
    ),
    // GetPage(
    //   transition: Transition.fadeIn,
    //   name: AppRoutes.login,
    //   // page: () => LoginPage(),
    //   // binding: FavoriteBinding(),
    // ),
    GetPage(
      transition: Transition.fadeIn,
      name: AppRoutes.splash,
      page: () => Splashview(),
      // binding: FavoriteBinding(),
    ),
  ];
}
