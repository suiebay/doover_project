import 'package:doover_project_test/core/widgets/nav_bar_item_widget.dart';
import 'package:flutter/material.dart';

import 'core/consts/colors.dart';
import 'features/basket/presentation/basket_page.dart';
import 'features/laundry/presentation/widgets/laundry_list_view.dart';
import 'features/profile/presentation/profile_page.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> _bodyWidgets = [
    LaundryListView(),
    ProfilePage(),
    BasketPage()
  ];

  void refresh(int currentView) {
    setState(() {
      _currentView = currentView;
    });
  }

  int _currentView = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DooverColors.kScaffoldBackgroundColor,
      body: Stack(children: [_bodyWidgets.elementAt(_currentView)]),
      bottomNavigationBar: Material(
        elevation: 30,
        child: Container(
            height: 53,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                NavBarItemWidget('assets/laundry.svg', 'Прачечная', _currentView, refresh: refresh),
                NavBarItemWidget('assets/profile.svg', 'Профиль', _currentView, refresh: refresh),
                NavBarItemWidget('assets/basket.svg', 'Корзина', _currentView, refresh: refresh),
              ],
            )
        ),
      ),
    );
  }
}
