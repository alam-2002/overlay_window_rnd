import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:overlay_window_rnd/components/common_methods.dart';
import 'package:workmanager/workmanager.dart';

class FlutterOverlayScreen extends StatefulWidget {
  FlutterOverlayScreen({super.key});

  @override
  State<FlutterOverlayScreen> createState() => _FlutterOverlayScreenState();
}

class _FlutterOverlayScreenState extends State<FlutterOverlayScreen> with WidgetsBindingObserver {
  AppLifecycleState? _appState;
  String receivedMessage = "No data received yet"; // To store the received value
  final TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // Get the current lifecycle state
    _appState = WidgetsBinding.instance.lifecycleState;
    print('Initial app state: $_appState');

    // /// 🔥 Listen to the data from main app
    // FlutterOverlayWindow.overlayListener.listen((data) {
    //   debugPrint("Overlay received data: $data");
    //   setState(() {
    //     receivedMessage = data ?? "No data received";
    //   });
    // });
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
            // Request
            ElevatedButton(
              onPressed: () {
                CommonMethods.requestOverlayPermission();
              },
              child: const Text("Request Overlay Permission"),
            ),
            const SizedBox(height: 20),

            // Show
            ElevatedButton(
              onPressed: () async {
                bool? isGranted = await FlutterOverlayWindow.isPermissionGranted();
                if (!isGranted) {
                  print('requestPermission pressed');
                  await FlutterOverlayWindow.requestPermission();
                } else {
                  print('showFirstOverlay pressed');
                  handleShowOverlay();
                  // CommonMethods.startChatHead();
                  print('Current app state - ${_appState}');
                }
              },
              child: const Text("Show Overlay"),
            ),
            const SizedBox(height: 20),

            // Close
            ElevatedButton(
              onPressed: () async {
                CommonMethods.closeOverlay();
                // CommonMethods.stopChatHead();
              },
              child: const Text("Close Overlay"),
            ),
            const SizedBox(height: 20),

            // Instant Overlay
            ElevatedButton(
              onPressed: () async {
                // print(receivedMessage);
                CommonMethods.showFirstOverlay();
              },
              child: const Text("Instant Overlay"),
            ),
            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: textController,
                decoration: InputDecoration(
                  labelText: 'Enter value to send to overlay',
                ),
              ),
            ),
            const SizedBox(height: 20),

            // value print
            ElevatedButton(
              onPressed: () async {
                // final value = 'This is testing Pickup & Drop Location';
                final value = textController.text.toString();
                CommonMethods.sendDataToOverlay(value);
                print('Data send to overlay => ${value}');
              },
              child: const Text("Send Value to Overlay"),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
