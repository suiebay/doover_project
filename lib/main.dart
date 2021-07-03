import 'package:doover_project_test/core/injection_container.dart';
import 'package:doover_project_test/features/authorization/presentation/login_page.dart';
import 'package:flutter/material.dart';
import 'package:doover_project_test/features/laundry/data/models/hint.dart';
import 'package:doover_project_test/features/laundry/data/models/laundry.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'features/laundry/presentation/screens/products_page.dart';
import 'main_screen.dart';

void main() async {

  await Hive.initFlutter();
  Hive.registerAdapter(HintAdapter());
  Hive.registerAdapter(LaundryAdapter());

  await Hive.openBox('auth');
  await Hive.openBox<Laundry>('basket');
  var sumBox = await Hive.openBox<double>('global');
  if(sumBox.get('sum') == null || sumBox.get('number') == null) {
    sumBox.put('sum', 0.0);
    sumBox.put('number', 0.0);
  }

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
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/main_screen': (context) => MainScreen(),
        '/products': (context) => ProductsPage(),
      },
    );
  }
}
