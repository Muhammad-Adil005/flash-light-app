import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';

class DarkLightThemeScreen extends StatefulWidget {
  const DarkLightThemeScreen({super.key});

  @override
  State<DarkLightThemeScreen> createState() => _DarkLightThemeScreenState();
}

class _DarkLightThemeScreenState extends State<DarkLightThemeScreen> {
  ThemeMode _themeMode = ThemeMode.system;
  bool _isDark = false;

  void changeTheme(bool isDark) {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
      _isDark = isDark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          color: Colors.black,
        ),
      ),
      themeMode: _themeMode,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Device Controlled theme Mode'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /* Text(
                'Choose your theme:',
              ),*/
              FlutterSwitch(
                width: 125.w,
                height: 55.h,
                valueFontSize: 25.0,
                toggleSize: 45.sp,
                value: _isDark,
                borderRadius: 30.0,
                padding: 8.0,
                //showOnOff: true,
                showOnOff: false,
                onToggle: (val) {
                  changeTheme(val);
                },
              ),
              SizedBox(height: 20.h),
              /* Text(
                _themeMode == ThemeMode.dark ? 'Dark theme' : 'Light theme',
              )*/
            ],
          ),
        ),
      ),
    );
  }
}
