import 'package:flutter/material.dart';

import 'navigation_list_item.dart';

class NavigationExpandedListItem extends StatelessWidget {
  final String title;
  final List<String> children;
  final Function onPressed;

  const NavigationExpandedListItem({
    Key key,
    @required this.title,
    @required this.children,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor,
            blurRadius: 2,
          ),
        ],
      ),
      child: ExpansionTile(
        title: Text(
          title,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        children: <Widget>[
          for (int i = 0; i < children.length; i++)
            NavigationSubListItem(
              title: children[i],
              onPressed: () => onPressed(i),
            ),
        ],
      ),
    );
  }
}