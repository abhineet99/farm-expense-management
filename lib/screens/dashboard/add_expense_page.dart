import 'dart:async';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:farm_expense_management/blocs/expenses_bloc.dart';
import 'package:farm_expense_management/blocs/field_bloc.dart';
import 'package:farm_expense_management/common/helpers.dart';
import 'package:farm_expense_management/common/models/expenses.dart';
import 'package:farm_expense_management/common/models/fields.dart';
import 'package:farm_expense_management/common/models/tag.dart';
import 'package:farm_expense_management/common/ui/pal_button.dart';
import 'package:farm_expense_management/common/ui/pal_title_view.dart';
import 'package:farm_expense_management/common/ui/multiselect.dart';
import 'package:farm_expense_management/screens/dashboard/tags_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:farm_expense_management/locale/locale.dart';
import 'package:farm_expense_management/common/database_manager/initialise_fields.dart';

class AddExpensePage extends StatefulWidget {
  final Field field;

  AddExpensePage({@required this.field});
  @override
  AddExpensePageState createState() {
    return AddExpensePageState();
  }
}

class AddExpensePageState extends State<AddExpensePage> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final amountController = TextEditingController();
  final currencyController = TextEditingController();
  final tagController = TextEditingController();
  final tagFocusNode = FocusNode();
  final List<Tag> tags = [];
  
  List <MultiSelectDialogItem<String>> multiTags =List();
  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();
  List <String> tagNames=List();

  @override
  void initState() {
    super.initState();
    for (Tag tag in widget.field.tags){
      tagNames.add(tag.name);
    }
    //choose color form first tag or set to green
    if(widget.field.tags.length>0)
    currentColor=widget.field.tags[0].color;
    else currentColor=Colors.green;

  }

  final _formKey = GlobalKey<FormState>();

  Color currentColor = Colors.green;
  DateTime currentDate = DateTime.now();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    amountController.dispose();
    currencyController.dispose();
    tagController.dispose();
    tagFocusNode.dispose();
    super.dispose();
  }

  changeColor(Color color) => setState(() => currentColor = color);

  Future _selectDate() async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(currentDate.year - 1),
        lastDate: DateTime(currentDate.year + 1));
    if (picked != null)
      setState(() {
        DateTime now = DateTime.now();
        DateTime date = DateTime.utc(
            picked.year, picked.month, picked.day, now.hour, now.minute);
        currentDate = date;
      });
  }

  void addTag(String newValue ,BuildContext context) {
    if (newValue.trim().length < 1) return;

    tags.removeWhere((tag) => tag.name == newValue.trim());

    Tag tag = Tag(name: newValue.trim(), color: currentColor);
    tagController.text = "";

    setState(() {
      tags.add(tag);
    });

    FocusScope.of(context).requestFocus(tagFocusNode);
  }

  void addMultipleTags(List<String> newTags, BuildContext context){
    setState(() {
      tags.clear();
    });
    for(String newValue in newTags){
      addTag(newValue, context);
    }
  }

  void populateMultiSelect(){
    multiTags=List();
    for (Tag tag in widget.field.tags){
      multiTags.add(MultiSelectDialogItem(tag.name,InitialiseFields().getLocalizedTagText(tag.name, context) ));
    }
  }
  

  void _showMultiSelect(BuildContext context) async {
    populateMultiSelect();
    final items = multiTags;
    List<String> selectedTagNames=List();
    for(Tag tag in tags){
      selectedTagNames.add(tag.name);
    }
    final selectedValues = await showDialog<Set<String>>(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectDialog(
          dialogueHeading: Text(AppLocalizations.of(context).tags_1).data,
          items: items,
          initialSelectedValues: selectedTagNames.toSet() ,
        );
      },
    );
    if (selectedValues!=null){
      addMultipleTags(selectedValues.toList(), context);
    } 
    
  }

  Widget _createbody(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.all(4.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      Flexible(
                        child: PalTitleView(title: Text(AppLocalizations.of(context).add).data),
                      ),
                      Container(
                        width: 40.0,
                      ),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(Icons.title),
                      title: TextFormField(
                        controller: titleController,
                        decoration: InputDecoration(

                          hintText: Text(AppLocalizations.of(context).expenseTitle).data,
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return Text(AppLocalizations.of(context).valEnterTitle).data;
                          }
                        },
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.attach_money),
                      title: TextFormField(
                        controller: amountController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: Text(AppLocalizations.of(context).amount).data,
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return Text(AppLocalizations.of(context).valEnterAmount).data;
                          }
                        },
                      ),
                      trailing: Container(
                        width: 50.0,
                        child: TextField(
                          controller: currencyController,
                          decoration: InputDecoration(
                            hintText: "INR", 
                          ),
                        ),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.description),
                      title: TextField(
                        controller: descriptionController,
                        decoration: InputDecoration(
                          hintText: Text(AppLocalizations.of(context).description).data,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.label),
                      title: SimpleAutoCompleteTextField(
                        key: key,
                        decoration: new InputDecoration(hintText: Text(AppLocalizations.of(context).tag_1).data),
                        controller: TextEditingController(text: ""),
                        suggestions: tagNames,
                        clearOnSubmit: true,
                        textSubmitted: (newValue) => setState(() {
                              if (newValue != "") {
                                addTag(newValue, context);
                              }
                            }
                          ),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.check_box),
                        color: currentColor,
                        onPressed:()=> _showMultiSelect(context) ,
                        ),
                    ),
                    ListTile(
                      title: tags.length > 0
                          ? RemoveableExpenseTags(
                              tags: tags,
                              removeAction: (tag) {
                                setState(() {
                                  tags.remove(tag);
                                });
                              },
                            )
                          : Center(
                              child: Text(
                                Text(AppLocalizations.of(context).noTagsYet).data,
                                style: TextStyle(
                                color: Colors.black54, fontSize: 14.0),

                              ),
                            ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.today),
                      title:  Text(AppLocalizations.of(context).date_1),
                      subtitle: Text(
                        DateHelper.formatDate(
                          currentDate,
                          fullDate: true,
                          withTime: true,
                        ),
                      ),
                      onTap: _selectDate,
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: PalButton(
                        title: Text(AppLocalizations.of(context).add).data,
                        width: MediaQuery.of(context).size.width * (2.0 / 3.0),
                        colors: [Colors.green[900], Colors.green[900]],
                        onPressed: () {
                          if (!_formKey.currentState.validate()) {
                            return;
                          }
                          Expense expense = Expense(
                              title: titleController.text,
                              description: descriptionController.text,
                              date: currentDate,
                              amount:
                                  double.tryParse(amountController.text) ?? 0.0,
                              currency: currencyController.text.isNotEmpty
                                  ? currencyController.text
                                  : "INR",
                              fieldName: widget.field.name,
                              tags: tags);
                          fieldsBloc.addTags(widget.field,tags);
                          expensesBloc.addExpense(expense,widget.field);
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context){
    return _createbody(context);
  }
}
