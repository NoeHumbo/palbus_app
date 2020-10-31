import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:palbus_app/screens/app/app_screen.dart';
import 'package:palbus_app/screens/home/home_screen.dart';
import 'package:palbus_app/screens/home/login_screen.dart';
import 'package:palbus_app/screens/home/signin_screen.dart';
import 'package:palbus_app/screens/home/splash_screen.dart';
import 'package:palbus_app/screens/others/list_payments.dart';
import 'package:palbus_app/screens/others/maps_screen.dart';
import 'package:palbus_app/screens/others/settings_screen.dart';
import 'package:palbus_app/screens/transactions/payment_screen.dart';
import 'package:palbus_app/screens/transactions/recharge_screen.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  // todo check conection
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PalBus',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [const Locale('es', 'PE')],
      theme: ThemeData(
        primaryColor: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash_screen',
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/splash_screen':
            return buildPageRouteBuilder(
                page: SplashScreen(), context: context);
          case '/app':
            return buildPageRouteBuilder(page: AppScreen(), context: context);
          case '/login':
            return buildPageRouteBuilder(page: LoginScreen(), context: context);
          case '/sign_in':
            return buildPageRouteBuilder(
                page: SigninScreen(), context: context);
          case '/home':
            return buildPageRouteBuilder(page: HomeScreen(), context: context);
          case '/maps':
            return buildPageRouteBuilder(page: MapsScreen(), context: context);
          case '/settings':
            return buildPageRouteBuilder(
                page: SettingsScreen(), context: context);
          case '/payment':
            return buildPageRouteBuilder(
                page: PaymentScreen(), context: context);
          case '/list_payments':
            return buildPageRouteBuilder(
                page: ListPaymentsScreen(), context: context);
          case '/recharge':
            return buildPageRouteBuilder(
                page: RechargeScreen(), context: context);
        }
        return null;
      },
    );
  }

  Route buildPageRouteBuilder({BuildContext context, Widget page}) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => page,
      transitionDuration: Duration(milliseconds: 300),
      transitionsBuilder: (context, animation, _, child) {
        return FadeTransition(
          opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.easeOut,
            ),
          ),
          child: child,
        );
      },
    );
  }
}
