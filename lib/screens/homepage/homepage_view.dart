// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';
import 'package:tamil_glossary/routes/pages.dart';
import 'package:tamil_glossary/routes/routes.dart';
import 'package:tamil_glossary/screens/setting/setting_view.dart';
// import 'package:tamil_glossary/screens/words_description/view.dart';
import 'package:tamil_glossary/utils/colors.dart';

import '../favorite/favourite_view.dart';
import 'homepage_controller.dart';

class Homeview extends StatelessWidget {
  final homePageCtrl = Get.put(HomeController());
  Homeview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, res) {
          homePageCtrl.focusNode.unfocus();
          print("your did pop is ---> $didPop");
          print("your object values is ---> $res");
        },
        child: SafeArea(
          child: Obx(()=> Scaffold(
            // appBar: AppBar(),
            backgroundColor: Colors.grey.shade100,
            bottomNavigationBar: BottomNavigationBar(
              
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.search),
                  label: 'search',
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.square_fill_line_vertical_square),
                  label: 'Favourite',
                ),
                // BottomNavigationBarItem(
                //   icon: Icon(CupertinoIcons.settings_solid),
                //   label: 'Setting',
                // ),
              ],
              currentIndex: homePageCtrl.selectedIndex.value,
              selectedItemColor: AppColors.appbarcolor,
              unselectedItemColor: Colors.grey,
              onTap: homePageCtrl.onItemTapped,
            ),
            body: Obx(()=> [
              CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  systemOverlayStyle: SystemUiOverlayStyle(
                    // Status bar color
                    statusBarColor: AppColors.appbarcolor,

                    // Status bar brightness (optional)
                    statusBarIconBrightness:
                        Brightness.dark, // For Android (dark icons)
                    statusBarBrightness:
                        Brightness.light, // For iOS (dark icons)
                  ),
                  snap: false,
                  pinned: true,
                  floating: true,
                  title: Text("Dictionary",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: Colors.white)),
                  centerTitle: false,

                  collapsedHeight: 70,
                  bottom: PreferredSize(
                      preferredSize:
                          const Size(double.infinity, kToolbarHeight),
                      child: Container(
                          child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: TextFormField(
                          
                          onChanged: (query) {
                           if(query.isNotEmpty){
                             homePageCtrl.deBouncer
                                .run(() => homePageCtrl.getWords(query));
                           }else{
                            homePageCtrl.deBouncer.dispose();
                            homePageCtrl.findedwords.clear();
                           }
                          },
                          focusNode: homePageCtrl.focusNode,
                          controller: homePageCtrl.wordcontroller.value,
                          onFieldSubmitted: homePageCtrl.getWords,
                          decoration: InputDecoration(
                            hintText: "Search for something...",
                            hintStyle: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: Colors.black54),
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.black54,
                            ),
                            suffixIcon: Icon(
                              Icons.mic,
                              color: Colors.black54,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 3.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 1.0),
                            ),

                            filled: true,
                            fillColor: Colors.white,
                            // border: OutlineInputBorder(),
                          ),
                        ),
                      ))),

                  expandedHeight: 120,

                  backgroundColor: AppColors.appbarcolor,

                  actions: <Widget>[
                    IconButton(
                      icon: Icon(Icons.language, color: Colors.white),
                      tooltip: 'Language',
                      onPressed: () {},
                    ), //IconButton
                    //IconButton
                  ], //<Widget>[]
                ), //SliverAppBar
                Obx(() => SliverPadding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => ListTile(
                            
                            leading: Text(
                              "${index + 1}",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            onTap: () => Get.toNamed(AppRoutes.wordsDescription,
                                arguments: homePageCtrl.findedwords[index]),
                            title: Text(
                              homePageCtrl.findedwords[index].title ?? "",
                            ),
                            trailing:  GestureDetector(
                              onTap:(){
                                homePageCtrl.saveWords(homePageCtrl.findedwords[index].title ?? "", homePageCtrl.findedwords[index].snippet??"");
                                
                            },
                              child: homePageCtrl.findedwords[index].selected??false?
                              Icon(Icons.bookmark,
                              color: AppColors.appbarcolor)
                              :Icon(Icons.bookmark_add_outlined,
                              color: Colors.grey),
                            ),
                          ), //ListTile
                          childCount: homePageCtrl.findedwords.length,
                        ), //SliverChildBuildDelegate
                      ),
                    )) //SliverList
              ], //<Widget>[]
            )
            ,Favoritewords()].elementAt(homePageCtrl.selectedIndex.value))
          ),
       ) ));
  }


}
