import 'package:doover_project_test/core/consts/colors.dart';
import 'package:doover_project_test/core/consts/text_styles.dart';
import 'package:doover_project_test/features/laundry/data/models/laundry.dart';
import 'package:doover_project_test/features/laundry/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class BasketPage extends StatefulWidget {
  @override
  _BasketPageState createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  final box = Hive.box<Laundry>('basket');
  var sumBox = Hive.box<double>('global');

  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Корзина',
          style: DooverTextStyles.kAppBarTextStyle,
        ),
        backgroundColor: DooverColors.kCardBackgroundColor,
        brightness: Brightness.light,
        elevation: 0,
        iconTheme: IconThemeData(
            color: DooverColors.kBottomNavBarSelectedItemColor
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Center(
              child: InkWell(
                onTap: () {
                  setState(() {
                    box.clear();
                    sumBox.put('sum', 0);
                  });
                },
                child: Hive.box<Laundry>('basket').isNotEmpty ? Text(
                  'Очистить',
                  style: DooverTextStyles.kLogOutTextStyle,
                ) : Container(),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 130),
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return ProductCard(box.values.elementAt(index), notifyParent: refresh);
              },
              itemCount: box.values.length,
            ),
          ),
          Hive.box<Laundry>('basket').isNotEmpty ? Positioned(
            bottom: 0,
            child: Material(
              elevation: 30,
              child: Container(
                height: 126,
                width: MediaQuery.of(context).size.width,
                color: DooverColors.kCardBackgroundColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Общая сумма ${sumBox.get('sum').toInt()}тг',
                            style: DooverTextStyles.kAppBarTextStyle,
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Text(
                              '${box.values.length} вещи',
                              style: DooverTextStyles.kNumbersTextStyle,
                            ),
                          ),
                        ]
                      ),
                      Spacer(),
                      SizedBox(
                        height: 43,
                        width: 343,
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(6.0)
                          ),
                          color: DooverColors.kButtonColor,
                          onPressed: () {

                          },
                          child: Text(
                            'Оформить',
                            style: DooverTextStyles.kLogInTextStyle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ) : Container(),
        ]
      ),
    );
  }
}

