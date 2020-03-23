import 'package:farm_expense_management/common/models/fields.dart';
import 'package:farm_expense_management/common/models/tag.dart';
import 'package:farm_expense_management/blocs/field_bloc.dart';

class InitialiseFields {
  static List<Tag> agricultureTags =[Tag(name:'Tools'),Tag(name:'Labor')];
  static Field agriculture= Field(name: 'Agriculture', tags :agricultureTags);

  void addFieldsData(){
    fieldsBloc.addField(agriculture);
  }

}
final initialiseFields=InitialiseFields();