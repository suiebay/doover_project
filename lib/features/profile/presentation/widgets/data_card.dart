import 'package:doover_project_test/core/consts/colors.dart';
import 'package:doover_project_test/core/consts/text_styles.dart';
import 'package:doover_project_test/features/profile/presentation/widgets/notification_switch.dart';
import 'package:flutter/material.dart';

class DataCard extends StatelessWidget {
  final String title;
  final bool value;

  const DataCard(this.title, {this.value, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        height: 59,
        width: MediaQuery.of(context).size.width,
        color: DooverColors.kCardBackgroundColor,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: title == 'Уведомления'
                    ? DooverTextStyles.kNotificationTextStyle
                    : DooverTextStyles.kLogOutTextStyle,
              ),
              value != null ? NotificationSwitch(value) : Container(),
            ],
          ),
        )
    );
  }
}
