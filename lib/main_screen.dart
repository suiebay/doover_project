import 'package:doover_project_test/core/widgets/nav_bar_item_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'core/consts/colors.dart';
import 'features/basket/presentation/basket_page.dart';
import 'features/laundry/presentation/screens/products_page.dart';
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

  int _currentView = 0;
  int _lastView;
  bool onMain = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DooverColors.kScaffoldBackgroundColor,
      body: _currentView == 0 ? Navigator(
        onGenerateRoute: (routeSettings) {
          return CupertinoPageRoute(
            builder: (context) => _bodyWidgets.elementAt(_currentView),
          );
        },
      ) : _bodyWidgets.elementAt(_currentView),

      bottomNavigationBar: Material(
        elevation: 30,
        child: CupertinoTabBar(
          backgroundColor: DooverColors.kCardBackgroundColor,
          border: Border(top: BorderSide(color: Colors.transparent)),
          onTap: (int index) {
            setState(() {
              _lastView = _currentView;
              _currentView = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: NavBarItemWidget('assets/laundry.svg', 'Прачечная', _currentView),
            ),
            BottomNavigationBarItem(
              icon: NavBarItemWidget('assets/profile.svg', 'Профиль', _currentView),
            ),
            BottomNavigationBarItem(
              icon: NavBarItemWidget('assets/basket.svg', 'Корзина', _currentView),
            ),
          ],
        ),
      ),
    );
  }
}
