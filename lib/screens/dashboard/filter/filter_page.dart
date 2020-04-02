import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:farm_expense_management/common/models/fields.dart';
import 'package:farm_expense_management/common/models/tag.dart';
import 'package:farm_expense_management/common/ui/multiselect.dart';
import 'package:farm_expense_management/common/ui/pal_button.dart';
import 'package:farm_expense_management/common/ui/pal_title_view.dart';
import 'package:farm_expense_management/screens/dashboard/filter/filter.dart';
import 'package:farm_expense_management/screens/dashboard/tags_ui.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:farm_expense_management/locale/locale.dart';

class FilterPage extends StatefulWidget {
  final Field field;
  FilterPage(this.field);
  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  final _dateRangeFetcher = BehaviorSubject<DateFilterType>();
  final _keywordController = TextEditingController();
  final tagController = TextEditingController();
  final tagFocusNode = FocusNode();

  final List<Tag> tags = [];
  Color currentColor;
  
  List <MultiSelectDialogItem<String>> multiTags =List();
  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();
  List <String> tagNames=List();

  @override
  void initState(){
    super.initState();
  //choose color form first tag or set to green
    if(widget.field.tags.length>0)
    currentColor=widget.field.tags[0].color;
    else currentColor=Colors.green;
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
      multiTags.add(MultiSelectDialogItem(tag.name,tag.name));
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
          dialogueHeading: 'Tags',
          items: items,
          initialSelectedValues: selectedTagNames.toSet() ,
        );
      },
    );
    if (selectedValues!=null){
      addMultipleTags(selectedValues.toList(), context);
    } 
    
  }


  @override
  dispose() {
    super.dispose();
    _keywordController.dispose();
    _dateRangeFetcher.close();
  }

  @override
  Widget build(BuildContext context) {
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
                        child: PalTitleView(title: Text(AppLocalizations.of(context).filter_1).data),
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
                // key: _formKey,
                child: ListView(
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(Icons.text_fields),
                      title: TextFormField(
                        controller: _keywordController,
                        decoration: InputDecoration(
                          hintText: Text(AppLocalizations.of(context).keyWord_1).data,
                        ),
                      ),
                    ),
                    StreamBuilder(
                      stream: _dateRangeFetcher.stream,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        return ListTile(
                          leading: const Icon(Icons.date_range),
                          title: DropdownButton<DateFilterType>(
                            isExpanded: true,
                            value: snapshot.hasData ? snapshot.data : null,
                            items: <DateFilterType>[
                              DateFilterType.today,
                              DateFilterType.yesterday,
                              DateFilterType.week,
                              DateFilterType.month,
                              DateFilterType.year,
                              // DateFilterType.custom
                            ].map((DateFilterType value) {
                              return DropdownMenuItem<DateFilterType>(
                                value: value,
                                child: Text(DateFilterTypeName(context,value)),
                              );
                            }).toList(),
                            onChanged: changedDropDownItem,
                          ),
                          trailing: snapshot.hasData
                              ? IconButton(
                                  icon: Icon(Icons.clear),
                                  onPressed: () {
                                    _dateRangeFetcher.sink.add(null);
                                  },
                                )
                              : null,
                        );
                      },
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
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: PalButton(
                        title: Text(AppLocalizations.of(context).apply_1).data,
                        width: MediaQuery.of(context).size.width * (2.0 / 3.0),
                        colors: [Colors.green[900], Colors.green[900]],
                        onPressed: () {
                          List<ExpenseFilter> filters = [];

                          if (_keywordController.text != null &&
                              _keywordController.text.trim().isNotEmpty) {
                            filters.add(KeywordFilter(
                                keyword: _keywordController.text.trim()));
                          }

                          var dateRangeType = _dateRangeFetcher.stream.value;
                          if (dateRangeType != null) {
                            filters.add(DateFilter(type: dateRangeType));
                          }

                          if(tags.isNotEmpty){
                            filters.add(TagFilter(tags: tags));
                          }

                          filtersBloc.setFilters(filters);

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

  void changedDropDownItem(DateFilterType selectedRange) {
    _dateRangeFetcher.sink.add(selectedRange);
  }
}
