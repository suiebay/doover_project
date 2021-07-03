import 'package:doover_project_test/core/consts/colors.dart';
import 'package:doover_project_test/core/consts/text_styles.dart';
import 'package:flutter/material.dart';

class DooverAppBar extends StatelessWidget {
  final String title;

  const DooverAppBar(this.title, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return title != 'Прачечная' ? AppBar(
      title: Text(
        title,
        style: DooverTextStyles.kAppBarTextStyle,
      ),
      backgroundColor: DooverColors.kCardBackgroundColor,
      brightness: Brightness.light,
      elevation: 0,
      iconTheme: IconThemeData(
          color: DooverColors.kBottomNavBarSelectedItemColor
      ),
    ) : Container();
  }
}
