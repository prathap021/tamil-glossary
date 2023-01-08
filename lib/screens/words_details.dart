// ignore_for_file: must_be_immutable, prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:tamil_glossary/database/dbhelper.dart';
import 'package:tamil_glossary/model/wordsdb_model.dart';

import '../model/words_model.dart';

class WordsDetails extends StatefulWidget {
  Tamilwords findedwords;

  WordsDetails({Key? key, required this.findedwords}) : super(key: key);

  @override
  State<WordsDetails> createState() => _WordsDetailsState();
}

class _WordsDetailsState extends State<WordsDetails> {
  DBProvider dbProvider = DBProvider.db;
  WordsDb wordsDb = WordsDb();
  List<WordsDb> chekwords = [];

  getwords() async {
    await dbProvider.getAllWords().then((value) {
      setState(() {
        chekwords.addAll(value);
      });
    });
  }

  wordcheking() async {
    debugPrint("word favorited level 0");
    wordsDb.title = widget.findedwords.title;
    wordsDb.description = widget.findedwords.snippet;
    await dbProvider.savewords(wordsDb);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.greenAccent,
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 10, right: 10, bottom: 5),
                          child: Container(
                            child: Text(
                              widget.findedwords.title.toString(),
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.all(10),
                            child: Container(
                              child: Html(
                                data: widget.findedwords.snippet,
                                style: {
                                  "body": Style(
                                    fontSize: FontSize(15.0),
                                    fontWeight: FontWeight.w600,
                                  ),
                                },
                              ),
                            )),
                        IconButton(
                            onPressed: () {
                              wordcheking().then((value) {
                                setState(() {
                                  debugPrint(value.toString());
                                  getwords();
                                  debugPrint(chekwords.length.toString());
                                });
                              });
                            },
                            icon: Icon(Icons.favorite)),
                      ],
                    ),
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios_new_sharp)),
            ],
          ),
        ),
      ),
    );
  }
}
