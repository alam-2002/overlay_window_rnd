import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:overlay_window_rnd/components/background_service.dart';
import 'package:overlay_window_rnd/components/common_methods.dart';
import 'package:overlay_window_rnd/components/overlay_widget_top.dart';
import 'package:overlay_window_rnd/components/overlay_widget_bottom.dart';
import 'package:overlay_window_rnd/screen/api_call_screen.dart';
import 'package:overlay_window_rnd/screen/flutter_overlay_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

/// Main Function ()
Future<void> main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();
  await BackgroundService.initializeService();

  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  runApp(MyApp());

  /// Listen for messages from the overlay
  // FlutterOverlayWindow.overlayListener.listen((data) async {
  //   if (data != null && data['action'] == 'launch_google_maps') {
  //     final origin = data['origin'];
  //     final destination = data['destination'];
  //     await Future.delayed(Duration(seconds: 1)); // Small delay to ensure the app is active
  //     _launchGoogleMap(
  //       origin: origin,
  //       destination: destination,
  //     );
  //   }
  // });

  // // Listen to the overlay stream only once
  // FlutterOverlayWindow.overlayListener.listen((event) {
  //   print("Current Event: $event");
  // });
}

/// First Overlay entry point (Appears at bottom)
@pragma("vm:entry-point")
Future<void> overlayMain() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: OverlayApp(),
      home: OverlayWidgetBottom(
        onCancelPressed: () async {
          print('Driver cancelled the request');
          await FlutterOverlayWindow.closeOverlay();
        },
        onAcceptPressed: () async {
          print('Accept pressed, switching to second overlay');
          // CommonMethods.sendValueToOverlay("Hello Overlay World!");
          // CommonMethods.sendValueToOverlay2(
          //   pickupLocation: 'This is Pickup Location',
          //   dropLocation: 'This is Drop Location',
          // );
          await FlutterOverlayWindow.closeOverlay();
          overlayMain2(); // Show second overlay
          await FlutterOverlayWindow.showOverlay(
            height: 1000,
            enableDrag: false,
            alignment: OverlayAlignment.topCenter,
            startPosition: OverlayPosition(0, 0),
            positionGravity: PositionGravity.auto,
            visibility: NotificationVisibility.visibilityPublic,
            flag: OverlayFlag.defaultFlag,
          );

          // Send data after starting the overlay
          // sendMessageToOverlay();
          // Future.delayed(Duration(seconds: 1), () {
          //   sendMessageToOverlay();
          // });
        },
      ),
    ),
  );

  // Auto-remove overlay after 30 seconds
  Timer(Duration(seconds: 30), () async {
    print('First Overlay removed, timeout');
    await FlutterOverlayWindow.closeOverlay();
  });
}

/// Second Overlay entry point (Appears at Top)
@pragma("vm:entry-point")
Future<void> overlayMain2() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter bindings are initialized

  // final prefs = await SharedPreferences.getInstance();
  // final String message = prefs.getString('overlay_message') ?? "No data passed";
  // print("Overlay Message ===> $message");

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OverlayWidgetTop(
        onCancelPressed: () async {
          print('Driver cancelled the request');
          await FlutterOverlayWindow.closeOverlay();
        },
        onAcceptPressed: () async {
          await FlutterOverlayWindow.closeOverlay();
          CommonMethods.launchGoogleMapAppView();
          // CommonMethods.launchGoogleMapsPiP();
        },
        // onAcceptPressed: () async {
        //   print('Sending request to launch Google Maps');
        //   final Map<String, dynamic> arguments = {
        //     'action': 'launch_google_maps',
        //     'origin': '18.6370204,73.8244481',
        //     'destination': '26.7324,88.4176',
        //   };
        //   await FlutterOverlayWindow.shareData(arguments);
        //   await FlutterOverlayWindow.closeOverlay();
        //   print('Google Maps launch request sent');
        // },
      ),
    ),
  );

  // Auto-remove overlay after 30 seconds
  Timer(Duration(seconds: 30), () async {
    print('Second Overlay removed, timeout');
    await FlutterOverlayWindow.closeOverlay();
  });
}

/// workmanager Method to show overlay from background state of app
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    print("Background Task Triggered: $task");
    CommonMethods.showFirstOverlay();

    // showFirstOverlay();

    return Future.value(true);
  });
}

// void sendValueToOverlay(String valueToPass) async {
//   final prefs = await SharedPreferences.getInstance();
//   await prefs.setString('overlay_message', valueToPass);
// }

// Future<String> sendValueToOverlay(String value) async {
//   await FlutterOverlayWindow.shareData(value); // This sends data
//   return value;
// }

// void sendMessageToOverlay() async {
//   await FlutterOverlayWindow.shareData({"message": "Hello from main app"});
//   // await FlutterOverlayWindow.sendData({"message": "Hello from main app"});
// }

// void listenToOverlayData() async {
//   FlutterOverlayWindow.overlayListener.listen((event) {
//     print("Received from main app: $event");
//   });
// }

// Future<void> showFirstOverlay() async {
//   await FlutterOverlayWindow.showOverlay(
//     height: 1400,
//     enableDrag: false,
//     alignment: OverlayAlignment.bottomCenter,
//     positionGravity: PositionGravity.auto,
//     visibility: NotificationVisibility.visibilityPublic,
//     flag: OverlayFlag.defaultFlag,
//   );
//
// // If user doesn't accept within 30 seconds, remove the overlay
//   Timer(Duration(seconds: 30), () async {
//     await FlutterOverlayWindow.closeOverlay();
//     print('showFirstOverlay removed, 30 seconds completed');
//   });
// }

/// Main APP ()
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FlutterOverlayScreen(),
      // home: MainScreen(),
    );
  }
}
