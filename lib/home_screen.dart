import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:torch_light/torch_light.dart';

class HomeScreen extends StatefulWidget {
  final bool isDark;
  final Function(bool) toggleTheme;

  HomeScreen({required this.isDark, required this.toggleTheme});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<bool>? _hasFlash;
  bool _isOn = false;

  @override
  void initState() {
    super.initState();
    _hasFlash = initPlatformState();
  }

  Future<bool> initPlatformState() async {
    bool hasFlash = (await TorchLight.isTorchAvailable) as bool;
    return hasFlash;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/background.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 10,
          backgroundColor: Colors.transparent,
          title: const Text('Flashlight App'),
          centerTitle: true,
          leading: FlutterSwitch(
            width: 50.w,
            height: 25.h,
            value: widget.isDark,
            onToggle: widget.toggleTheme,
          ),
        ),
        body: GestureDetector(
          onVerticalDragUpdate: (details) {
            if (details.primaryDelta! < -1) {
              // Swipe Up
              _turnFlash(true);
            } else if (details.primaryDelta! > 1) {
              // Swipe Down
              _turnFlash(false);
            }
          },
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 150.w,
                      height: 150.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _isOn ? Colors.yellow : Colors.transparent,
                      ),
                    ),
                    ButtonTheme(
                      minWidth: 150.w,
                      height: 40.h,
                      child: ElevatedButton(
                        child: Icon(
                          Icons.power_settings_new,
                          color: Colors.white,
                          size: 30.sp,
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          elevation: 10.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        onPressed: () => _turnFlash(!_isOn),
                      ),
                    ),
                  ],
                ),
                FutureBuilder<bool>(
                  future: _hasFlash,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Container(); // Empty container, as we don't need to show this text anymore.
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _turnFlash(bool turnOn) async {
    if (turnOn) {
      await TorchLight.enableTorch();
    } else {
      await TorchLight.disableTorch();
    }
    setState(() {
      _isOn = turnOn;
    });
  }
}
