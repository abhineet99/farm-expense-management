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
    Tag(name: 'Seed'),
    ];
    
  final Field agriculture= Field(name: 'Agriculture', tags :agricultureTags);

  void addFieldsData(){
    fieldsBloc.addField(agriculture);
  }

}
final initialiseFields=InitialiseFields();