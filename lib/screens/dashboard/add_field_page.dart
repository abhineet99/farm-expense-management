import 'package:farm_expense_management/blocs/field_bloc.dart';
import 'package:farm_expense_management/common/models/fields.dart';
import 'package:farm_expense_management/common/models/tag.dart';
import 'package:farm_expense_management/common/ui/pal_button.dart';
import 'package:farm_expense_management/common/ui/pal_title_view.dart';
import 'package:farm_expense_management/common/ui/single_tag.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:farm_expense_management/locale/locale.dart';
class AddFieldPage extends StatefulWidget {
  @override
  AddFieldPageState createState() {
    return AddFieldPageState();
  }
}

class AddFieldPageState extends State<AddFieldPage> {
  final nameController = TextEditingController();
  final tagController = TextEditingController();
  final tagFocusNode = FocusNode();
  final List<Tag> tags = [];

  final _formKey = GlobalKey<FormState>();

  Color currentColor = Color(0xff443a49);
  DateTime currentDate = DateTime.now();

  @override
  void dispose() {
    nameController.dispose();
    tagController.dispose();
    tagFocusNode.dispose();
    super.dispose();
  }

  changeColor(Color color) => setState(() => currentColor = color);

  void addTag(String newValue, BuildContext context) {
    if (newValue.trim().length < 1) return;

    tags.removeWhere((tag) => tag.name == newValue.trim());

    Tag tag = Tag(name: newValue.trim(), color: currentColor);
    tagController.text = "";

    setState(() {
      tags.add(tag);
    });

    FocusScope.of(context).requestFocus(tagFocusNode);
  }
  Widget _createBody(BuildContext context) {
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
                        controller: nameController,
                        decoration: InputDecoration(
                          hintText: Text(AppLocalizations.of(context).name_1).data,
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please enter title";
                          }
                        },
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.label),
                      title: TextField(
                        controller: tagController,
                        focusNode: tagFocusNode,
                        onChanged: (newValue) {
                          if (newValue.endsWith(',')) {
                            addTag(newValue.replaceAll(",", ""), context);
                          }
                        },
                        onSubmitted: (newValue) {
                          addTag(newValue, context);
                        },
                        decoration: InputDecoration(
                          hintText: Text(AppLocalizations.of(context).tag_1).data,
                        ),
                      ),
                      trailing: Container(
                        width: 40.0,
                        child: FlatButton(
                          onPressed: () {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  titlePadding: const EdgeInsets.all(0.0),
                                  contentPadding: const EdgeInsets.all(0.0),
                                  content: SingleChildScrollView(
                                    child: ColorPicker(
                                      pickerColor: currentColor,
                                      onColorChanged: changeColor,
                                      colorPickerWidth: MediaQuery.of(context).size.width - 32.0,
                                      pickerAreaHeightPercent: 0.7,
                                      enableAlpha: true,
                                    ),
                                  ),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: const Text('OK'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          color: currentColor,
                          child: null,
                        ),
                      ),
                    ),
                    ListTile(
                      title: tags.length > 0
                          ? _RemoveableExpenseTags(
                              tags: tags,
                              removeAction: (tag) {
                                setState(() {
                                  tags.remove(tag);
                                });
                              },
                            )
                          : Center(
                              child: Text(
                                AppLocalizations.of(context).noTagMsg,
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 14.0),
                              ),
                            ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: PalButton(
                        title: AppLocalizations.of(context).add,
                        width: MediaQuery.of(context).size.width * (2.0 / 3.0),
                        colors: [Colors.green[600], Colors.green[900]],
                        onPressed: () {
                          if (!_formKey.currentState.validate()) {
                            return;
                          }
                          Field field=Field(
                            name: nameController.text,
                            tags: tags
                          );
                          fieldsBloc.addField(field);
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
  Widget build(BuildContext context) {
    return _createBody(context);
    
  }
}

class _RemoveableExpenseTags extends StatelessWidget {
  final List<Tag> tags;
  final SingleTagCallback removeAction;

  _RemoveableExpenseTags({@required this.tags, this.removeAction});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24.0,
      child: Center(
        child: ListView.builder(
          itemCount: tags.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            Tag tag = tags[index];
            return Center(
              child: Padding(
                padding: EdgeInsets.only(
                    right: index == tags.length - 1 ? 0.0 : 4.0),
                child: SingleTag(
                  tag: tag,
                  removeAction: removeAction,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
