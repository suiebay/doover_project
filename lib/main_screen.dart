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
    BasketPage(),
  ];

  final List<String> _widgetTitles = [
    'Прачечная',
    'Профиль',
    'Корзина',
  ];

  int _currentView = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DooverColors.kScaffoldBackgroundColor,
      body: _bodyWidgets.elementAt(_currentView),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentView,
        selectedItemColor: Colors.black87,
        onTap: (int index) {
          setState(() {
            _currentView = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: _widgetTitles[0],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.panorama_rounded),
            label: _widgetTitles[1],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_box),
            label: _widgetTitles[2],
          ),
        ],
      ),
    );
  }
}
