// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tamil_glossary/database/dbhelper.dart';
import 'package:tamil_glossary/model/wordsdb_model.dart';

class Favoritewords extends StatefulWidget {
  const Favoritewords({Key? key}) : super(key: key);

  @override
  State<Favoritewords> createState() => _FavoritewordsState();
}

class _FavoritewordsState extends State<Favoritewords> {
  DBProvider dbProvider = DBProvider.db;
  List<WordsDb> wordsdb = [];
  bool loading = false;
  @override
  void initState() {
    super.initState();
    debugPrint('histroty fetching');
    getwords();
  }

  getwords() async {
    await dbProvider.getAllWords().then((value) {
      setState(() {
        wordsdb.addAll(value);
        debugPrint(wordsdb.length.toString());

        if (value.isNotEmpty) {
          loading = true;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: () async {
                      await dbProvider.deleteAllWords();
                      setState(() {
                        loading = false;
                      });
                    },
                    icon: Icon(Icons.delete))
              ],
              title: Text("Favorite words"),
            ),
            body: loading
                ? ListView.builder(
                    itemCount: wordsdb.length,
                    itemBuilder: ((context, index) {
                      return ListTile(
                        trailing: IconButton(
                            onPressed: () async {
                              await dbProvider
                                  .delete(wordsdb[index]
                                      .title
                                      .toString()
                                      .trim()
                                      .toString())
                                  .then((value) {
                                setState(() {
                                  wordsdb.removeAt(index);
                                  if (wordsdb.isEmpty) {
                                    loading = false;
                                  }
                                });
                              });
                            },
                            icon: Icon(Icons.delete)),
                        title: Text(wordsdb[index].title.toString()),
                      );
                    }),
                  )
                : Center(child: Text("Favorite is Empty"))));
  }
}
