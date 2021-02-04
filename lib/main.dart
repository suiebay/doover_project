import 'package:doover_project_test/core/injection_container.dart';
import 'package:doover_project_test/features/authorization/presentation/login_page.dart';
import 'package:flutter/material.dart';
import 'package:doover_project_test/features/laundry/data/models/hint.dart';
import 'package:doover_project_test/features/laundry/data/models/laundry.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {

  await Hive.initFlutter();
  Hive.registerAdapter(HintAdapter());
  Hive.registerAdapter(LaundryAdapter());
  await Hive.openBox('auth');
  await Hive.openBox<Laundry>('basket');
  var sumBox = await Hive.openBox<double>('global');
  if(sumBox.isEmpty) { sumBox.put('sum', 0); }
  print(Hive.box<Laundry>('basket').values);
  setupInjections();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
    );
  }
}
