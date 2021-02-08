import 'package:doover_project_test/core/consts/colors.dart';
import 'package:doover_project_test/core/consts/text_styles.dart';
import 'package:doover_project_test/core/injection_container.dart';
import 'package:doover_project_test/features/authorization/controllers/auth_bloc/auth_bloc.dart';
import 'package:doover_project_test/features/authorization/data/models/auth.dart';
import 'package:doover_project_test/features/authorization/presentation/widgets/text_field_card.dart';
import 'package:doover_project_test/main_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DooverColors.kScaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Войти',
          style: DooverTextStyles.kAppBarTextStyle,
        ),
        brightness: Brightness.light,
        backgroundColor: DooverColors.kCardBackgroundColor,
        elevation: 0,
      ),
      body: BlocProvider(
        create: (_) => getIt<AuthBloc>(),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if(state is AuthSuccess) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => MainScreen()),
              );
            }
          },
          builder: (context, state) {
            return Column(
              children: <Widget>[
                SizedBox(height: 25),
                TextFieldCard('Логин', usernameController),
                TextFieldCard('Пароль', passwordController),
                SizedBox(height: 35),
                SizedBox(
                  height: 43,
                  width: 343,
                  child: CupertinoButton(
                    // shape: RoundedRectangleBorder(
                    //   borderRadius:
                    //   BorderRadius.circular(6.0)
                    // ),
                    padding: EdgeInsets.all(0),
                    borderRadius: BorderRadius.circular(6),
                    color: DooverColors.kButtonColor,
                    onPressed: () {
                      Auth auth = Auth('inzgiba', usernameController.text, passwordController.text);
                      BlocProvider.of<AuthBloc>(context).add(AuthSubmitted(auth));
                    },
                    child: state is AuthLoading ? SizedBox(
                        height: 24,
                        width: 24,
                        child: Theme(
                          data: ThemeData(
                            cupertinoOverrideTheme: CupertinoThemeData(brightness: Brightness.dark)),
                          child: CupertinoActivityIndicator(),
                      ),
                    ) : Text(
                      'Войти',
                      style: DooverTextStyles.kLogInTextStyle,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
