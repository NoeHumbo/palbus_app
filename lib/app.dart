import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:palbus_app/screens/app/app_screen.dart';
import 'package:palbus_app/screens/app/splash_screen.dart';
import 'package:palbus_app/screens/home/home_screen.dart';
import 'package:palbus_app/screens/home/login_screen.dart';
import 'package:palbus_app/screens/home/signin_screen.dart';
import 'package:palbus_app/screens/others/maps_screen.dart';
import 'package:palbus_app/screens/others/settings_screen.dart';
import 'package:palbus_app/screens/transactions/payment_screen.dart';

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
            return buildPageRouteBuilder(page: SplashScreen());
          case '/app':
            return buildPageRouteBuilder(page: AppScreen());
          case '/login':
            return buildPageRouteBuilder(page: LoginScreen());
          case '/sign_in':
            return buildPageRouteBuilder(page: SigninScreen());
          case '/home':
            return buildPageRouteBuilder(page: HomeScreen());
          case '/maps':
            return buildPageRouteBuilder(page: MapsScreen());
          case '/settings':
            return buildPageRouteBuilder(page: SettingsScreen());
          case '/payment':
            return buildPageRouteBuilder(page: PaymentScreen());
        }
        return null;
      },
    );
  }

  PageRouteBuilder buildPageRouteBuilder({Widget page}) {
    return PageRouteBuilder(
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) =>
          page,
    );
  }
}
