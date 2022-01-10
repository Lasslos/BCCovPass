import 'dart:convert';

import 'package:bc_cov_pass/provider/vaccine_information_provider.dart';
import 'package:bc_cov_pass/vaccine_information.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'widgets/home_page.dart';
import 'widgets/init_app.dart';

const String vaccineInformationPath = 'vaccine_information';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var sharedPreferences = await SharedPreferences.getInstance();
  var vaccineInformation = sharedPreferences.containsKey(vaccineInformationPath)
      ? VaccineInformation.fromJSON(
          jsonDecode(sharedPreferences.getString(vaccineInformationPath)!))
      : null;
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => VaccineInformationProvider(vaccineInformation))
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) => MaterialApp(
          theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: const Color(0xFFFCBA19),
            scaffoldBackgroundColor: const Color(0xFF003366),
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: const Color(0xFFFCBA19),
            scaffoldBackgroundColor: const Color(0xFF003366),
          ),
          initialRoute: context.read<VaccineInformationProvider>().vaccineInformation != null ? '/home' : '/initApp',
          routes: {
            '/home': (context) => const HomePage(),
            '/initApp': (context) => InitApp(),
          });
}
