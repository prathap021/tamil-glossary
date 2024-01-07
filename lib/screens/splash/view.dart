import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tamil_glossary/screens/splash/controller.dart';

class Splashview extends StatelessWidget {
  final splah = Get.put(SplashController());
  Splashview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 300,
            width: double.infinity,
            child: Image.asset("asset/images/books.png"),
          ),
          Text("தமிழ்  அகராதி ")
          // Text(
          //   '',
          //   style: GoogleFonts.kavivanar(
          //     textStyle: TextStyle(color: Colors.blue, letterSpacing: .5),
          //   ),
          // ),
        ],
      ),
    );
  }
}
