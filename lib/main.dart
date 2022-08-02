import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:provider/provider.dart';

import 'lang/app_localization.dart';
import 'providers/orders_provider.dart';
import 'screens/home_screen.dart';
import 'screens/order_details_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const MrsoolAcceptApp());
}

class MrsoolAcceptApp extends StatefulWidget {
  const MrsoolAcceptApp({Key? key}) : super(key: key);
  static void setLocale(BuildContext context, Locale locale) async {
    final appState = context.findAncestorStateOfType<_MrsoolAcceptAppState>();

    appState!.setLocale(context, locale);
  }

  @override
  State<MrsoolAcceptApp> createState() => _MrsoolAcceptAppState();
}

class _MrsoolAcceptAppState extends State<MrsoolAcceptApp> {
  final routes = {
    HomeScreen.routeName: (_) => const HomeScreen(),
    OrderDetailsScreen.routeName: (_) => const OrderDetailsScreen(),
  };

  void setLocale(BuildContext context, Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  Locale? _locale;

  @override
  Widget build(BuildContext context) {
    final theme = appTheme;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => OrdersProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Accept App',
        theme: theme,
        locale: _locale,
        supportedLocales: const [
          Locale('en', ''),
          Locale('ar', ''),
        ],
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: const HomeScreen(),
        routes: routes,
      ),
    );
  }
}
