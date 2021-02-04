import 'package:doover_project_test/core/consts/colors.dart';
import 'package:doover_project_test/core/injection_container.dart';
import 'package:doover_project_test/features/profile/controllers/notification_bloc/notification_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationSwitch extends StatefulWidget {
  final bool value;

  const NotificationSwitch(this.value, {Key key}) : super(key: key);

  @override
  _NotificationSwitchState createState() => _NotificationSwitchState();
}

class _NotificationSwitchState extends State<NotificationSwitch> {
  bool isSwitched;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<NotificationBloc>(),
      child: BlocConsumer<NotificationBloc, NotificationState>(
        listener: (context, state) {
          if(state is NotificationSuccess) {
          setState(() {
            isSwitched = state.settings.notify;
          });
          }
        },
        builder: (context, state) {
          if(state is NotificationFailure) {
            return Text(state.message);
          }

          return SizedBox(
            height: 31,
            width: 51,
            child: CupertinoSwitch(
              value: isSwitched ?? widget.value,
              onChanged: (value) {
                BlocProvider.of<NotificationBloc>(context).add(NotificationSwitched(value));
              },
              activeColor: DooverColors.kButtonColor,
            ),
          );
        }
      ),
    );
  }
}
