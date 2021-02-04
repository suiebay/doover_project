import 'package:doover_project_test/core/consts/colors.dart';
import 'package:doover_project_test/core/consts/text_styles.dart';
import 'package:doover_project_test/features/laundry/data/models/laundry.dart';
import 'package:flutter/material.dart';

class DooverBottomSheet extends StatelessWidget {
  final Laundry product;

  const DooverBottomSheet(this.product, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 204,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                  children: [
                    Text(
                      product.hint.title,
                      style: DooverTextStyles.kDialogueTitleTextStyle,
                    ),
                    Spacer(),
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: DooverColors.kQuestionBackgroundColor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8.0),
                            topRight: Radius.circular(8.0)),
                      ),
                      child: Center(
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Icon(
                              Icons.close,
                              color: DooverColors.kBottomNavBarSelectedItemColor,
                              size: 18,
                            ),
                          )
                      ),
                    ),
                  ]
              ),
              SizedBox(height: 24,),
              Text(
                product.hint.description,
                style: DooverTextStyles.kNotificationTextStyle,
              )
            ],
          ),
        ),
      ),
    );
  }
}
