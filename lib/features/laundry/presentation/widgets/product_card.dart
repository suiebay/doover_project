import 'package:doover_project_test/core/consts/colors.dart';
import 'package:doover_project_test/core/consts/text_styles.dart';
import 'package:doover_project_test/features/laundry/data/models/laundry.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'bottom_sheet.dart';

class ProductCard extends StatefulWidget {
  final Laundry product;
  final Function notifyParent;

  const ProductCard(this.product, {Key key, this.notifyParent}) : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  var box = Hive.box<Laundry>('basket');
  var sumBox = Hive.box<double>('global');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Container(
        height: 102,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: DooverColors.kCardBackgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            SizedBox(width: 10),
            Image(
              height: 64,
              image: NetworkImage("https://avatanplus.com/files/resources/original/5b8b9070149b6165992c35d4.png"),
            ),
            SizedBox(width: 23),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                Container(
                  width: MediaQuery.of(context).size.width - 169,
                  child: Text(
                    widget.product.name,
                    style: DooverTextStyles.kNumbersTextStyle,
                    overflow: TextOverflow.ellipsis
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      'Срок чистки / ',
                      style: DooverTextStyles.kDeadlineTextStyle,
                    ),
                    Text(
                      '${widget.product.duration ~/ 86400} дня',
                      style: DooverTextStyles.kNumbersTextStyle,
                    )
                  ]
                ),
                SizedBox(height: 8),
                Container(
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            widget.product.counter++;
                            sumBox.put('sum', sumBox.get('sum') + widget.product.price);
                            box.put(widget.product.productId, widget.product);
                            if(widget.notifyParent != null) widget.notifyParent();
                          });
                        },
                        child: Icon(
                          Icons.add_circle_outline_rounded,
                          color: DooverColors.kBottomNavBarSelectedItemColor
                        ),
                      ),
                      SizedBox(width: 12),
                      widget.product.counter > 0 ? Text(
                        '${widget.product.counter}',
                        style: DooverTextStyles.kNumbersTextStyle,
                      ) : Container(),
                      SizedBox(width: 12),
                      widget.product.counter > 0 ? InkWell(
                        onTap: () {
                          setState(() {
                            widget.product.counter--;
                            sumBox.put('sum', sumBox.get('sum') - widget.product.price);
                            if(widget.product.counter != 0)
                              box.put(widget.product.productId, widget.product);
                            else
                              box.delete(widget.product.productId);
                            if(widget.notifyParent != null) widget.notifyParent();
                          });
                        },
                        child: Icon(
                          Icons.remove_circle_outline_rounded,
                          color: DooverColors.kBottomNavBarSelectedItemColor
                        ),
                      ) : Container(),
                    ],
                  ),
                ),
              ]
            ),
            Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        barrierColor: Colors.black.withOpacity(0.8),
                        context: context,
                        builder: (BuildContext bc){
                          return DooverBottomSheet(widget.product);
                        }
                    );
                  },
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: DooverColors.kQuestionBackgroundColor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8.0),
                          topRight: Radius.circular(8.0)),
                    ),
                    child: Center(
                      child: Text(
                        '?',
                        style: DooverTextStyles.kQuestionIconTextStyle
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 14, 16),
                  child: Text(
                    '${widget.product.price.toInt()} тг',
                    style: DooverTextStyles.kNumbersTextStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
