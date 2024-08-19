import 'package:hive/hive.dart'; 

part 'db_model.g.dart'; 

@HiveType(typeId: 1) 
class SaveWordsModel extends HiveObject { 
@HiveField(0) 
final String id; 
@HiveField(2) 
final String title; 
@HiveField(3) 
final String body; 
SaveWordsModel({ 
	required this.body, 
	required this.id, 

	required this.title, 
}); 
}
