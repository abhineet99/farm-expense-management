import 'package:farm_expense_management/common/ui/pal_button.dart';
import 'package:farm_expense_management/common/ui/pal_title_view.dart';
import 'package:farm_expense_management/screens/dashboard/filter/filter.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:farm_expense_management/locale/locale.dart';
class FilterPage extends StatelessWidget {
  final _dateRangeFetcher = BehaviorSubject<DateFilterType>();
  final _keywordController = TextEditingController();

  dispose() {
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
                    // ListTile(
                    //   leading: const Icon(Icons.attach_money),
                    //   title: TextFormField(
                    //     controller: amountController,
                    //     keyboardType: TextInputType.number,
                    //     decoration: InputDecoration(
                    //       hintText: "Amount",
                    //     ),
                    //     validator: (value) {
                    //       if (value.isEmpty) {
                    //         return "Please enter amount";
                    //       }
                    //     },
                    //   ),
                    //   trailing: Container(
                    //     width: 50.0,
                    //     child: TextField(
                    //       controller: currencyController,
                    //       decoration: InputDecoration(
                    //         hintText: "EUR",
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // ListTile(
                    //   leading: const Icon(Icons.description),
                    //   title: TextField(
                    //     controller: descriptionController,
                    //     decoration: InputDecoration(
                    //       hintText: "Description",
                    //     ),
                    //   ),
                    // ),
                    // ListTile(
                    //   leading: const Icon(Icons.label),
                    //   title: TextField(
                    //     controller: tagController,
                    //     focusNode: tagFocusNode,
                    //     onChanged: (newValue) {
                    //       if (newValue.endsWith(',')) {
                    //         addTag(newValue.replaceAll(",", ""), context);
                    //       }
                    //     },
                    //     onSubmitted: (newValue) {
                    //       addTag(newValue, context);
                    //     },
                    //     decoration: InputDecoration(
                    //       hintText: "Tag",
                    //     ),
                    //   ),
                    //   trailing: Container(
                    //     width: 40.0,
                    //     child: FlatButton(
                    //       onPressed: () {
                    //         showDialog(
                    //           context: context,
                    //           builder: (BuildContext context) {
                    //             return AlertDialog(
                    //               titlePadding: const EdgeInsets.all(0.0),
                    //               contentPadding: const EdgeInsets.all(0.0),
                    //               content: SingleChildScrollView(
                    //                 child: ColorPicker(
                    //                   pickerColor: currentColor,
                    //                   onColorChanged: changeColor,
                    //                   colorPickerWidth: 1000.0,
                    //                   pickerAreaHeightPercent: 0.7,
                    //                   enableAlpha: true,
                    //                 ),
                    //               ),
                    //             );
                    //           },
                    //         );
                    //       },
                    //       color: currentColor,
                    //       child: null,
                    //     ),
                    //   ),
                    // ),
                    // ListTile(
                    //   title: tags.length > 0
                    //       ? _RemoveableExpenseTags(
                    //           tags: tags,
                    //           removeAction: (tag) {
                    //             setState(() {
                    //               tags.remove(tag);
                    //             });
                    //           },
                    //         )
                    //       : Center(
                    //           child: Text(
                    //             'No tags yet. Add tag by typing in the field above. To confirm it just press Return or type a comma.',
                    //             style: TextStyle(
                    //                 color: Colors.black54, fontSize: 14.0),
                    //           ),
                    //         ),
                    // ),
                    // ListTile(
                    //   leading: const Icon(Icons.today),
                    //   title: const Text('Date'),
                    //   subtitle: Text(
                    //     DateHelper.formatDate(
                    //       currentDate,
                    //       fullDate: true,
                    //       withTime: true,
                    //     ),
                    //   ),
                    //   onTap: _selectDate,
                    // ),
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

                          // DateFilter(
                          //       dateTime: DateTime.utc(2019, 3, 11),
                          //       type: DateFilterType.equal)
                          filtersBloc.setFilters(filters);
                          // if (!_formKey.currentState.validate()) {
                          //   return;
                          // }
                          // Expense expense = Expense(
                          //     title: titleController.text,
                          //     description: descriptionController.text,
                          //     date: currentDate,
                          //     amount:
                          //         double.tryParse(amountController.text) ?? 0.0,
                          //     currency: currencyController.text.isNotEmpty
                          //         ? currencyController.text
                          //         : "EUR",
                          //     tags: tags);
                          // expensesBloc.addExpense(expense);
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
