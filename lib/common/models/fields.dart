import 'package:farm_expense_management/common/database_manager/database_model.dart';
import 'package:farm_expense_management/common/models/tag.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';


class Field extends DatabaseModel{
  final String name;
  List<Tag> tags;

  Field(
    {
    @required this.name,
    @required this.tags}
    );

  @override
  List<String> removeArgs(){
    return [name];
  }

  @override
  String removeQuery() {
    return 'name = ?';
  }

  @override
  Map<String, dynamic> toMap(){
    Map<String,dynamic> map={
      'name': name,
      'tags': jsonEncode(tags) //tags.map((tag) => tag.toJson())
    };

    return map;  
    }

  addTags(Tag tag){
    tags.add(tag);
  }
}


class FieldTable extends DatabaseTable {
  FieldTable()
      : super(
            'Fields',
            [
              'name',
              'tags'
            ],
            'name TEXT PRIMARY KEY, tags TEXT');

  @override
  DatabaseModel entryFromMap(Map map) {
    List<Tag> tags = (jsonDecode(map['tags']) as List<dynamic>).map((json) => Tag.fromJson(json)).toList();
    var entry = Field(
      name: map['name'],
      tags: tags,
    );

    return entry;
  }
}
