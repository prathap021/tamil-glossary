import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../model/words_model.dart';

class WordsDetails extends StatefulWidget {
  Tamilwords findedwords;

  WordsDetails({Key? key, required this.findedwords}) : super(key: key);

  @override
  State<WordsDetails> createState() => _WordsDetailsState();
}

class _WordsDetailsState extends State<WordsDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.white70,
            height: 100,
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios_new_sharp)),
          ),
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Colors.greenAccent,
              ),
              borderRadius: BorderRadius.circular(20.0), //<-- SEE HERE
            ),
            child: Column(
              children: [
                Container(
                  child: Text(widget.findedwords.title.toString()),
                ),
                Container(child: Html(data: widget.findedwords.snippet))
              ],
            ),
          )
        ],
      ),
    );
  }
}
