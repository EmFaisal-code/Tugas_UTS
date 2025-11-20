import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDark = false;

  @override
  void initState() {
    super.initState();
    loadTheme();
  }

  void loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isDark = prefs.getBool("theme") ?? false;
    });
  }

  void saveTheme(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("theme", value);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDark ? ThemeData.dark() : ThemeData.light(),
      home: HomePage(
        isDark: isDark,
        onThemeChange: (value) {
          setState(() {
            isDark = value;
            saveTheme(value);
          });
        },
      ),
    );
  }
}
