import 'package:doover_project_test/core/consts/text_styles.dart';
import 'package:doover_project_test/core/widgets/divider.dart';
import 'package:doover_project_test/features/authorization/controllers/auth_bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TextFieldCard extends StatelessWidget {
  final String hintText;
  final controller;

  const TextFieldCard(this.hintText, this.controller, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: Colors.transparent)),
                  fillColor: state is AuthFailure ? Colors.red.withOpacity(0.3) : Colors.white,
                  filled: true,
                  hintText: hintText,
                  hintStyle: DooverTextStyles.kLogInHintTextStyle
              ),
              style: DooverTextStyles.kNotificationTextStyle,
              obscureText: hintText == 'Логин' ? false : true,
            ),
            hintText == 'Логин' ? DooverDivider() : Container(),
          ],
        );
      }
    );
  }
}
