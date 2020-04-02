import 'dart:async';
import 'dart:developer';
import 'package:farm_expense_management/common/database_manager/database_manager.dart';
import 'package:farm_expense_management/common/models/fields.dart';
import 'package:farm_expense_management/common/models/tag.dart';
import 'package:rxdart/rxdart.dart';

class FieldsBloc {
  final _fieldsFetcher = BehaviorSubject<List<Field>>();
  final manager = DatabaseManager.defaultManager;

  Observable<List<Field>> get allFields => _fieldsFetcher.stream;

  fetchAllFields() async {
    FieldTable table = FieldTable();
    List<Map> maps = await manager.fetchAllEntriesOf(Field);
    List<Field> fields = List();

    maps.forEach((map) {
      Field field = table.entryFromMap(map);
      fields.add(field);
    });

    fields.sort((f1, f2) => f1.name.compareTo(f2.name));
    log('Sinking Fetched Fields');
    _fieldsFetcher.sink.add(fields);
  }

  Future<bool> addField(Field field) async {
    return manager.insert([field])
      .then((value)=> fetchAllFields()
      .catchError((error)=>throw error)
      )
      ;
  }

  Future<bool> removeField(Field field) async {
    return manager.remove([field]).then((value) {
      fetchAllFields();
    });
  }

  Future<bool> addTag(Field field,Tag newTag,)async{
    if (field.tags.indexOf(newTag)!=-1) {
      return true;
    } 
    field.tags.add(newTag);
    removeField(field);                 //easy update, else need to encode and decode tags as json objects
    return addField(field);
  }

  Future<bool> addTags(Field field,List<Tag> newTags) async{
    bool output=true;
    newTags.forEach((newTag)async{
        await addTag(field, newTag).then((value){
         output=value;
       });
    });
    return output;
  }
  
  Future<bool> removeTag(Field field,Tag newTag){
    field.tags.removeWhere((tag) => tag==newTag);   //def any operation to == 
    removeField(field);                   //easy update, else need to encode and decode tags as json objects           
    return addField(field);    
  }

  dispose() {
    _fieldsFetcher.close();
  }
}

final fieldsBloc = FieldsBloc();
