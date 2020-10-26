import 'package:flutter/material.dart';
import 'package:palbus_app/app.dart';
import 'package:provider/provider.dart';
import 'services/connectivity/connectivity_store.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<ConnectivityStore>(
          create: (_) => ConnectivityStore(),
        ),
      ],
      child: App(),
    ),
  );
}