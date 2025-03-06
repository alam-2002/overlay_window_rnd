import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:workmanager/workmanager.dart';

class FlutterOverlayScreen extends StatefulWidget {
  FlutterOverlayScreen({super.key});

  @override
  State<FlutterOverlayScreen> createState() => _FlutterOverlayScreenState();
}

class _FlutterOverlayScreenState extends State<FlutterOverlayScreen> with WidgetsBindingObserver {
  AppLifecycleState? _appState;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // Get the current lifecycle state
    _appState = WidgetsBinding.instance.lifecycleState;
    print('Initial app state: $_appState');
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      _appState = state;
    });
    print('Updated app state: $_appState');
  }

  Future<void> requestOverlayPermission() async {
    bool? granted = await FlutterOverlayWindow.isPermissionGranted();
    if (granted == false) {
      await FlutterOverlayWindow.requestPermission();
    }
  }

  /// First Overlay (Appears at bottom)
  Future<void> showFirstOverlay() async {
    await FlutterOverlayWindow.showOverlay(
      height: 1400,
      // enableDrag: true,
      // alignment: OverlayAlignment.centerLeft,
      enableDrag: false,
      alignment: OverlayAlignment.bottomCenter,
      positionGravity: PositionGravity.auto,
      visibility: NotificationVisibility.visibilityPublic,
      flag: OverlayFlag.defaultFlag,
    );

    // If user doesn't accept within 30 seconds, remove the overlay
    // Timer(Duration(seconds: 30), () {
    //   removeOverlay();
    //   print('showFirstOverlay removed, 30 seconds completed');
    // });
  }

  /// Remove Overlay
  Future<void> removeOverlay() async {
    await FlutterOverlayWindow.closeOverlay();
    print('Overlay closed');
  }

  /// Check app state and handle overlay accordingly
  void handleShowOverlay() async {
    print('Checking app state before overlay: $_appState');

    if (_appState == AppLifecycleState.resumed || _appState == null) {
      print("App is in foreground, moving to background...");

      await SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop'); // Minimize app

      // Register background task to show overlay after 10 sec
      Workmanager().registerOneOffTask(
        "uniqueTaskId",
        "showOverlayTask",
        initialDelay: Duration(seconds: 10), // Wait 10 seconds
        // inputData: {
        //   "title": "Hello from WorkManager!",
        //   "content": "This is a background notification.",
        // },
      );
    } else {
      print("overlay is running");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("flutter_overlay_window")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: requestOverlayPermission,
              child: const Text("Request Overlay Permission"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                bool? isGranted = await FlutterOverlayWindow.isPermissionGranted();
                if (!isGranted) {
                  print('requestPermission pressed');
                  await FlutterOverlayWindow.requestPermission();
                } else {
                  print('showFirstOverlay pressed');
                  // showFirstOverlay();
                  handleShowOverlay();
                  print('Current app state - ${_appState}');
                }
              },
              child: const Text("Show Overlay"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                removeOverlay();
              },
              child: const Text("Close Overlay"),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
