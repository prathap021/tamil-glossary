import 'package:hive/hive.dart';
import 'package:tamil_glossary/model/db_model.dart';
import 'package:tamil_glossary/model/wordsdb_model.dart';

class Dbhelper {
  Box<SaveWordsModel> localDb = Hive.box<SaveWordsModel>('savedWords');

  void setWords(SaveWordsModel data)async{
  await localDb.put(data.title, data); 
  }

  void removeWords(String key) async{
    await localDb.delete(key); 
  }

  List<SaveWordsModel> getAllWords(){
    return localDb.values.toList();
  }

  Future<bool> isWordExist(String key)async {
    List<SaveWordsModel> list=localDb.values.toList();
    return  list.any((res)=> res.title==key);
  }
}