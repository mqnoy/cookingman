import 'package:cookingman/routing/router.dart';
import 'package:cookingman/routing/routes.dart';
import 'package:cookingman/service_locator.dart';
import 'package:cookingman/services/navigation_service.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initLocator();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      navigatorKey: sl<NavigationService>().navigatorKey,
      initialRoute: route_signin,
      onGenerateRoute: Routers.generateRoute,
    );
  }
}
