import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class ResponseWidget {
  showToast(String msg) {
    var tomsg = Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
    return tomsg;
  }
}
