import 'package:cookingman/features/signin/signin_provider.dart';
import 'package:cookingman/features/signin/signin_screen.dart';
import 'package:cookingman/features/signup/signup_provider.dart';
import 'package:cookingman/features/signup/signup_screen.dart';
import 'package:cookingman/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'routes.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case route_signin:
        return PageRouteBuilder(
          pageBuilder: (_, animation, secondaryAnimation) =>
              ChangeNotifierProvider.value(
            child: SignInScreen(),
            value: sl<SignInProvider>(),
          ),
          transitionsBuilder: (_, animation, secondaryAnimation, child) {
            return ScaleTransition(
              scale: Tween<double>(
                begin: 0.0,
                end: 1.0,
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.fastOutSlowIn,
                ),
              ),
              child: child,
            );
          },
        );
      case route_signup:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider.value(
            child: SignUpScreen(),
            value: sl<SignUpProvider>(),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
