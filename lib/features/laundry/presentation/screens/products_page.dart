import 'package:doover_project_test/core/consts/colors.dart';
import 'package:doover_project_test/core/widgets/app_bar.dart';
import 'package:doover_project_test/features/laundry/data/models/laundry.dart';
import 'package:doover_project_test/features/laundry/presentation/widgets/product_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doover_project_test/features/laundry/controllers/laundry_bloc/laundry_bloc.dart';
import 'package:hive/hive.dart';

class ProductsPage extends StatelessWidget {
  final String title;
  final box = Hive.box<Laundry>('basket');

  ProductsPage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DooverColors.kScaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: Size(
          MediaQuery.of(context).size.width,
          kToolbarHeight,
        ),
        child: DooverAppBar(title),
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
              padding: EdgeInsets.symmetric(vertical: 16),
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
            );
          }
          return Offstage();
        },
      ),
    );
  }
}




