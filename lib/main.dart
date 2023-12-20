import 'package:platform_converter_ios_android/provider/contact_provider.dart';
import 'package:platform_converter_ios_android/provider/month_provider.dart';
import 'package:platform_converter_ios_android/provider/theme_chenge_app_provider.dart';
import 'package:platform_converter_ios_android/screen/android/home.dart';
import 'package:platform_converter_ios_android/screen/ios/home_ios.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => ThemeChangeAppProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => ContactProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => MonthProvider(),
          ),
        ],
        builder: (context, _) {
          return (Provider.of<ThemeChangeAppProvider>(context).isAndroid)
              ? MaterialApp(
                  debugShowCheckedModeBanner: false,
                  routes: {
                    '/': (context) => const HomeA(),
                  },
                  theme: ThemeData.light(useMaterial3: true),
                  darkTheme: ThemeData.dark(useMaterial3: true),
                  themeMode: ThemeMode.system,
                )
              : CupertinoApp(
                  debugShowCheckedModeBanner: false,
                  routes: {
                    '/': (context) => const HomeI(),
                  },
                );
        });
  }
}
