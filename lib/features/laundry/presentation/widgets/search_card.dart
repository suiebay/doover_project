import 'package:doover_project_test/core/consts/colors.dart';
import 'package:doover_project_test/core/consts/padding.dart';
import 'package:doover_project_test/core/consts/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doover_project_test/features/laundry/controllers/laundry_bloc/laundry_bloc.dart';

class SearchCard extends StatefulWidget {
  final TextEditingController controller;

  const SearchCard(this.controller, {Key key}) : super(key: key);

  @override
  _SearchCardState createState() => _SearchCardState();
}

class _SearchCardState extends State<SearchCard> {
  bool cancel = false;
  bool cancelWord = false;

  onTextChanged(String text) async {
    BlocProvider.of<LaundryBloc>(context).add(LaundrySearchActivated(text));
    setState(() {
      if(text != '')
        cancel = true;
      else {
        cancel = false;
        BlocProvider.of<LaundryBloc>(context).add(LaundryLoaded());
      }
    });
  }

  onTextTap() async {
    setState(() {
      cancelWord = true;
    });
  }

  @override
  void initState() {
    widget.controller.text = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: DooverPaddings.kPostCardPadding,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Container(
                height: 36,
                width: cancelWord == false
                    ? MediaQuery.of(context).size.width
                    : MediaQuery.of(context).size.width - 110,
                decoration: BoxDecoration(
                  color: DooverColors.kCardBackgroundColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 8),
                    Icon(
                      Icons.search,
                      color: DooverColors.kBottomNavBarConstItemColor,
                    ),
                    SizedBox(width: 8),
                    Container(
                      width: MediaQuery.of(context).size.width - 180,
                      child: TextField(

                        inputFormatters: [LengthLimitingTextInputFormatter(20)],
                        controller: widget.controller,
                        style: DooverTextStyles.kOnSearchTextStyle,
                        decoration: new InputDecoration(
                          hintText: 'Найти вещь',
                          hintStyle: DooverTextStyles.kLogInHintTextStyle,
                          border: InputBorder.none),
                        onChanged: onTextChanged,
                        onTap: onTextTap,
                      ),
                    ),
                    widget.controller.text != '' ? InkWell(
                      onTap: () {
                        setState(() {
                          widget.controller.text = '';
                          cancel = false;
                        });
                        BlocProvider.of<LaundryBloc>(context).add(LaundryLoaded());
                      },
                      child: Icon(
                        Icons.clear,
                        color: DooverColors.kBottomNavBarConstItemColor,
                      ),
                    ) : Container(),
                  ],
                ),
              ),
              cancelWord == true ? Positioned(
                right: 0,
                bottom: -3,
                child: CupertinoButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    setState(() {
                      widget.controller.text = '';
                      cancel = false;
                      cancelWord = false;
                      FocusScope.of(context).unfocus();
                    });
                    BlocProvider.of<LaundryBloc>(context).add(LaundryLoaded());
                  },
                  child: Text(
                    'Отменить',
                    style: DooverTextStyles.kCancelTextStyle,
                  ),
                )
              ) : Container()
            ],
          ),
        )
    );
  }
}

