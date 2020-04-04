import 'package:farm_expense_management/common/models/fields.dart';
import 'package:farm_expense_management/common/models/tag.dart';
import 'package:farm_expense_management/blocs/field_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:farm_expense_management/locale/locale.dart';

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
    Tag(name: 'Machinery Maintenance'),
    Tag(name: 'Machinery Purchase'),
    Tag(name: 'Machinery Rent'),
    Tag(name: 'Pesticides'),
    Tag(name: 'Seeds'),
    Tag(name: 'Tools Purchase'),
    Tag(name: 'Tools Rent'),
    Tag(name: 'Tools Maintenance'),
    Tag(name: 'Transportation'),
    Tag(name: 'Weedicide'),
    ];   

  static List<Tag> dairyTags =[
    Tag(name: 'Animal Purchase'),
    Tag(name: 'Animal Medication'),
    Tag(name: 'Bedding'),
    Tag(name: 'Electricity'),
    Tag(name: 'Fodder'),
    Tag(name: 'Feed Supplements'),
    Tag(name: 'Insurance'),
    Tag(name: 'Labor'),
    Tag(name: 'Land Purchase'),
    Tag(name: 'Land Rent'),
    Tag(name: 'Machinery Maintenance'),
    Tag(name: 'Machinery Purchase'),
    Tag(name: 'Machinery Rent'),
    Tag(name: 'Shelter'),
    Tag(name: 'Tools Purchase'),
    Tag(name: 'Tools Rent'),
    Tag(name: 'Tools Maintenance'),
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

  Widget getLocalizedFieldWidget(String value,BuildContext context){ // !!!ATTENTION!!! If any new category is added, make changes here for language support
      Map<String,Widget> fieldsMap ={
        'agriculture':Text(AppLocalizations.of(context).agriculture),
        'dairy':Text(AppLocalizations.of(context).dairy),
      };
      return fieldsMap[value];
  }

  String getLocalizedFieldText(String value,BuildContext context){ // !!!ATTENTION!!! If any new category is added, make changes here for language support , note tha capital letter in names
      Map<String,String> fieldsMap ={
        'Agriculture':Text(AppLocalizations.of(context).agriculture).data,
        'Dairy':Text(AppLocalizations.of(context).dairy).data,
      };
      if(fieldsMap.containsKey(value))
        return fieldsMap[value];
      else
        return value;
  }

  String getLocalizedTagText(String value,BuildContext context){ // !!!ATTENTION!!! If any new default tag is added, make changes here for language support
      Map<String,String> tagMap ={
        'Collection and Packing':Text(AppLocalizations.of(context).tagCollectionAndPacking).data,
        'Fertilizers':Text(AppLocalizations.of(context).tagFertilizers).data,
        'Fodder':Text(AppLocalizations.of(context).tagFodder).data,
        'Insurance':Text(AppLocalizations.of(context).tagInsurance).data,
        'Irrigation Equipment':Text(AppLocalizations.of(context).tagIrrigationEquipment).data,
        'Irrigation Rent':Text(AppLocalizations.of(context).tagIrrigationRent).data,
        'Labor':Text(AppLocalizations.of(context).tagLabor).data,
        'Land Purchase':Text(AppLocalizations.of(context).tagLandPurchase).data,
        'Land Rent':Text(AppLocalizations.of(context).tagLandRent).data,
        'Machinery Maintenance':Text(AppLocalizations.of(context).tagMachineryMaintenance).data,
        'Machinery Purchase':Text(AppLocalizations.of(context).tagMachineryPurchase).data,
        'Machinery Rent':Text(AppLocalizations.of(context).tagMachineryRent).data,
        'Pesticides':Text(AppLocalizations.of(context).tagPesticides).data,
        'Seeds':Text(AppLocalizations.of(context).tagSeeds).data,
        'Tools Purchase':Text(AppLocalizations.of(context).tagToolsPurchase).data,
        'Tools Rent':Text(AppLocalizations.of(context).tagToolsRent).data,
        'Tools Maintenance':Text(AppLocalizations.of(context).tagToolsMaintenance).data,
        'Transportation':Text(AppLocalizations.of(context).tagTransportation).data,
        'Weedicide':Text(AppLocalizations.of(context).tagWeedicide).data,
        'Animal Purchase':Text(AppLocalizations.of(context).tagAnimalPurchase).data,
        'Animal Medication':Text(AppLocalizations.of(context).tagAnimalMedication).data,
        'Bedding':Text(AppLocalizations.of(context).tagBedding).data,
        'Electricity':Text(AppLocalizations.of(context).tagElectricity).data,
        'Shelter':Text(AppLocalizations.of(context).tagShelter).data,
        'Feed Supplements':Text(AppLocalizations.of(context).tagFeedSupplements).data,
        'Transportation':Text(AppLocalizations.of(context).tagTransportation).data,

      };
      if(tagMap.containsKey(value))
        return tagMap[value];
      else
        return value;
  }

  Future<dynamic> addFieldsData(String fieldName){
    return fieldsBloc.addField(fieldsMap[fieldName]);
  }

}
