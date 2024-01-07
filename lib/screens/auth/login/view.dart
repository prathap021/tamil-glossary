import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:tamil_glossary/screens/auth/login/controller.dart';
import 'package:tamil_glossary/utils/colors.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final login = Get.put(LoginController(context: context));
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage("asset/images/books.png"),
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              textAlign: TextAlign.start,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  hintText: 'Enter User Name',
                  hintStyle: TextStyle(fontSize: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.all(10),
                  fillColor: Colors.grey.shade300),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              textAlign: TextAlign.start,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  hintText: 'Enter password',
                  hintStyle: TextStyle(fontSize: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.all(10),
                  fillColor: Colors.grey.shade300),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(onPressed: login.fetchToken, child: Text("Log in ")),
//
          ],
        ),
      ),
    ));
  }
}
