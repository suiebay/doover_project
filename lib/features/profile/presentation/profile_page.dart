import 'package:doover_project_test/core/consts/colors.dart';
import 'package:doover_project_test/core/injection_container.dart';
import 'package:doover_project_test/core/widgets/app_bar.dart';
import 'package:doover_project_test/core/widgets/divider.dart';
import 'package:doover_project_test/features/authorization/presentation/login_page.dart';
import 'package:doover_project_test/features/laundry/data/models/laundry.dart';
import 'package:doover_project_test/features/profile/controllers/profile_bloc/profile_bloc.dart';
import 'package:doover_project_test/features/profile/data/models/user.dart';
import 'package:doover_project_test/features/profile/presentation/widgets/data_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class ProfilePage extends StatelessWidget {
  User profile;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProfileBloc>()..add(ProfileLoaded(profile)),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if(state is ProfileSuccess) {
            profile = state.profile;
          }
          return Scaffold(
            backgroundColor: DooverColors.kScaffoldBackgroundColor,
            appBar: PreferredSize(
              preferredSize: Size(
                MediaQuery.of(context).size.width,
                kToolbarHeight,
              ),
              child: DooverAppBar(state is ProfileSuccess ? state.profile.username : ''),
            ),
            body:
            state is ProfileLoading
              ? Center(child: CupertinoActivityIndicator(radius: 15))
              : state is ProfileFailure
              ? Text(state.message)
              : state is ProfileSuccess
              ? Column(
              children: [
                SizedBox(height: 25),
                DataCard('Уведомления', value: Hive.box('auth').get('notify')),
                DooverDivider(),
                FlatButton(
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      CupertinoPageRoute(builder: (BuildContext context) => LoginPage()),
                      ModalRoute.withName('/'),
                    );
                    Hive.box('auth').clear();
                    Hive.box<Laundry>('basket').clear();
                  },
                  child: DataCard('Выйти'),
                ),
              ],
            ) : Offstage()
          );
        },
      ),
    );
  }
}


