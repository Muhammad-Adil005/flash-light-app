// main.dart
// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDark = false;

  void toggleTheme(bool isDark) {
    setState(() {
      _isDark = isDark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flashlight App',
          theme: ThemeData.light(),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: Colors.black,
            scaffoldBackgroundColor: Colors.black,
            appBarTheme: AppBarTheme(
              color: Colors.black,
            ),
          ),
          themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,
          home: HomeScreen(
            isDark: _isDark,
            toggleTheme: toggleTheme,
          ),
        );
      },
    );
  }
}

/*import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Dark_&_light_Theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flash light App',
          home: //HomeScreen(),
              DarkLightThemeScreen(),
        );
      },
    );
  }
}*/
