import 'package:flutter/material.dart';

import 'package:movie_app/common/constants/size_constants.dart';
import 'package:movie_app/common/extensions/size_extensions.dart';
import 'package:movie_app/presentation/widgets/logo.dart';

import 'navigation_expanded_list_item.dart';
import 'navigation_list_item.dart';

class NavigationDrawer extends StatelessWidget {

  const NavigationDrawer();

  @override
  Widget build(BuildContext context) {

    return Container(
      width: Sizes.dimen_300.w,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.7),
            blurRadius: 4,
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                top: Sizes.dimen_8.h,
                bottom: Sizes.dimen_18.h,
                left: Sizes.dimen_8.w,
                right: Sizes.dimen_8.h,
              ),
              child: Logo(
                height: Sizes.dimen_20.h,
              ),
            ),
            NavigationListItem(
              title: 'Favorite Movies',
              onPressed: () {},
            ),
            NavigationExpandedListItem(
              title: 'Language',
              children: [
                'English',
                'Spanish',
              ],
              onPressed: (index) {},
            ),
            NavigationListItem(
              title: 'Feedback',
              onPressed: () {},
            ),
            NavigationListItem(
              title: 'About',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}