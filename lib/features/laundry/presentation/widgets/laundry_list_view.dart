import 'package:doover_project_test/core/injection_container.dart';
import 'package:doover_project_test/features/laundry/data/models/laundry.dart';
import 'package:doover_project_test/features/laundry/presentation/screens/products_page.dart';
import 'package:doover_project_test/features/laundry/presentation/widgets/laundry_card.dart';
import 'package:doover_project_test/features/laundry/presentation/widgets/product_card.dart';
import 'package:doover_project_test/features/laundry/presentation/widgets/search_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doover_project_test/features/laundry/controllers/laundry_bloc/laundry_bloc.dart';
import 'package:hive/hive.dart';

class LaundryListView extends StatelessWidget {
  final TextEditingController controller = new TextEditingController();
  final box = Hive.box<Laundry>('basket');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (_) => getIt<LaundryBloc>()..add(LaundryLoaded()),
        child: Stack(
          children: [
            SearchCard(controller),
            BlocBuilder<LaundryBloc, LaundryState>(
              builder: (context, state) {
                if (state is LaundryLoading) {
                  return Center(child: CircularProgressIndicator());
                }

                if (state is LaundryFailure) {
                  return Center(child: Text(state.message));
                }

                if (state is LaundrySuccess) {
                  return Container(
                    margin: EdgeInsets.only(top: 60),
                    child: ListView.separated(
                      itemBuilder: (context, index) =>
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                            child: FlatButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => BlocProvider(
                                            create: (_) => getIt<LaundryBloc>()..add(LaundryProductsLoaded(
                                                  state.categories[index].categoryId)),
                                            child: ProductsPage(
                                                title: state.categories[index].name),
                                          ),
                                    ),
                                  );
                                },
                                child: CategoryCard(state.categories[index])
                            ),
                          ),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 10),
                      itemCount: state.categories.length,
                    ),
                  );
                }

                if (state is LaundrySearchSuccess) {
                  return Container(
                    margin: EdgeInsets.only(top: 60),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          print(box.containsKey(state.products[index].productId));
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
                  );
                }

                return Offstage();
              },
            ),
          ]
        ),
      ),
    );
  }
}
