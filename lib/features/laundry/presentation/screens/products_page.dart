import 'package:doover_project_test/core/config.dart';
import 'package:doover_project_test/core/consts/colors.dart';
import 'package:doover_project_test/core/widgets/app_bar.dart';
import 'package:doover_project_test/features/laundry/data/models/laundry.dart';
import 'package:doover_project_test/features/laundry/presentation/widgets/product_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doover_project_test/features/laundry/controllers/laundry_bloc/laundry_bloc.dart';
import 'package:hive/hive.dart';

class Global {
  static var x;
  static void back() {
    Navigator.pop(x);
  }
}

class ProductsPage extends StatefulWidget {
  final String title;
  ProductsPage({Key key, this.title}) : super(key: key);

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final box = Hive.box<Laundry>('basket');

  @override
  Widget build(BuildContext context) {
    Global.x = context;
    return Scaffold(
      backgroundColor: DooverColors.kScaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: Size(
          MediaQuery.of(context).size.width,
          kToolbarHeight,
        ),
        child: DooverAppBar(widget.title),
      ),
      body: BlocBuilder<LaundryBloc, LaundryState>(
        builder: (context, state) {
          if(state is LaundryLoading) {
            return Center(child: CupertinoActivityIndicator(radius: 15));
          }
          if(state is LaundryFailure) {
            return Text(state.message);
          }

          if(state is LaundryProductsSuccess) {
            return Padding(
              padding: EdgeInsets.only(top: 16, bottom: 4),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        if(box.containsKey(state.products[index].productId)) {
                          Laundry boxProduct = box.get(state.products[index].productId);
                          return ProductCard(boxProduct);
                        } else {
                          return ProductCard(state.products[index]);
                        }
                      },
                      itemCount: state.products.length,
                    ),
                  ),
                ],
              ),
            );
          }
          return Offstage();
        },
      ),
    );
  }
}




