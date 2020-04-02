import 'package:farm_expense_management/common/models/tag.dart';
import 'package:farm_expense_management/common/ui/single_tag.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class RemoveableExpenseTags extends StatelessWidget {
  final List<Tag> tags;
  final SingleTagCallback removeAction;

  RemoveableExpenseTags({@required this.tags, this.removeAction});

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
