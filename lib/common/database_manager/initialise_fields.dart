import 'package:farm_expense_management/common/models/fields.dart';
import 'package:farm_expense_management/common/models/tag.dart';
import 'package:farm_expense_management/blocs/field_bloc.dart';

class InitialiseFields {
  static List<Tag> agricultureTags =[
    Tag(name: 'Collection and Packing'),
    Tag(name: 'Fertilizers'),
    Tag(name: 'Fodder'),
    Tag(name: 'Insurance'),
    Tag(name: 'Irrigation Equipment'),
    Tag(name: 'Irrigation Rent'),
    Tag(name: 'Labor'),
    Tag(name: 'Land Purchase'),
    Tag(name: 'Land Rent'),
    Tag(name: 'Machinery Maintainance'),
    Tag(name: 'Machinery Purchase'),
    Tag(name: 'Machinery Rent'),
    Tag(name: 'Pesticides'),
    Tag(name: 'Seeds'),
    Tag(name: 'Tools Purchase'),
    Tag(name: 'Tools Rent'),
    Tag(name: 'Tools Maintainance'),
    Tag(name: 'Transportation'),
    Tag(name: 'Weedicide'),
    ];   

  static List<Tag> dairyTags =[
    Tag(name: 'Animal Purchase'),
    Tag(name: 'Animal Medication'),
    Tag(name: 'Bedding'),
    Tag(name: 'Electricity'),
    Tag(name: 'Fodder'),
    Tag(name: 'Feed Suppliments'),
    Tag(name: 'Insurance'),
    Tag(name: 'Labor'),
    Tag(name: 'Land Purchase'),
    Tag(name: 'Land Rent'),
    Tag(name: 'Machinery Maintainance'),
    Tag(name: 'Machinery Purchase'),
    Tag(name: 'Machinery Rent'),
    Tag(name: 'Shelter'),
    Tag(name: 'Tools Purchase'),
    Tag(name: 'Tools Rent'),
    Tag(name: 'Tools Maintainance'),
    Tag(name: 'Transportation'),
    ];
  
  static Field agriculture= Field(name: 'Agriculture', tags :agricultureTags);
  static Field dairy= Field(name: 'Dairy',tags :dairyTags);

  final Map<String,Field> fieldsMap ={
    'agriculture':agriculture,
    'dairy':dairy,
  };

  List<String> getFieldNames(){
    return fieldsMap.keys.toList();
  }

  Future<dynamic> addFieldsData(String fieldName){
    return fieldsBloc.addField(fieldsMap[fieldName]);
  }

}
