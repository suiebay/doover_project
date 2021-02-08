import 'package:doover_project_test/core/consts/colors.dart';
import 'package:doover_project_test/core/consts/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NavBarItemWidget extends StatelessWidget {
  final Function refresh;
  final String imgUrl;
  final String title;
  final int _currentView;

  NavBarItemWidget(this.imgUrl, this.title, this._currentView, {this.refresh, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(3),
      child: CupertinoButton(
        padding: EdgeInsets.all(0),
        onPressed: () {
          if(title == 'Прачечная')
            refresh(0);
          if(title == 'Профиль')
            refresh(1);
          if(title == 'Корзина')
            refresh(2);
        },
        child: Container(
          decoration: BoxDecoration(
            color: (_currentView == 0 || _currentView == 3) && title == 'Прачечная' ? DooverColors.kBottomNavBarSelectedBackgroundColor
                : _currentView == 1 && title == 'Профиль' ? DooverColors.kBottomNavBarSelectedBackgroundColor
                : _currentView == 2 && title == 'Корзина' ? DooverColors.kBottomNavBarSelectedBackgroundColor
                : Colors.white,
            borderRadius: BorderRadius.circular(6),
          ),
          width: MediaQuery.of(context).size.width / 3 - 6,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                imgUrl,
                semanticsLabel: 'Acme Logo',
                height: 24,
                color: (_currentView == 0 || _currentView == 3) && title == 'Прачечная' ? DooverColors.kBottomNavBarSelectedItemColor
                    : _currentView == 1 && title == 'Профиль' ? DooverColors.kBottomNavBarSelectedItemColor
                    : _currentView == 2 && title == 'Корзина' ? DooverColors.kBottomNavBarSelectedItemColor
                    : DooverColors.kBottomNavBarConstItemColor,
              ),
              SizedBox(height: 7,),
              Text(
                title,
                style: (_currentView == 0 || _currentView == 3) && title == 'Прачечная' ? DooverTextStyles.kNavBarSelectedTextStyle
                    : _currentView == 1 && title == 'Профиль' ? DooverTextStyles.kNavBarSelectedTextStyle
                    : _currentView == 2 && title == 'Корзина' ? DooverTextStyles.kNavBarSelectedTextStyle
                    : DooverTextStyles.kNavBarConstTextStyle,
              )
            ],
          ),
        ),
      ),
    );
  }
}
