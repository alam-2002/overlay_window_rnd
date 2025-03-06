import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:overlay_window_rnd/components/background_service.dart';
import 'package:overlay_window_rnd/components/overlay_widget_top.dart';
import 'package:overlay_window_rnd/components/overlay_widget_bottom.dart';
import 'package:overlay_window_rnd/screen/flutter_overlay_screen.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:workmanager/workmanager.dart';

/// Temporary URL for launching google map
const String kGoogleMapUrl =
    "https://www.google.com/maps/dir/?api=1&origin=18.6370204,73.8244481&destination=26.7324,88.4176&dir_action=navigate&travelmode=driving";

/// Main Function ()
void main() async {
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
}

/// First Overlay (Appears at bottom)
@pragma("vm:entry-point")
void overlayMain() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: Column(
      //   children: [
      //     ChatHeadOverlay(),
      //     OverlayWidgetBottom(
      //       onCancelPressed: () async {
      //         print('Driver cancelled the request');
      //         await FlutterOverlayWindow.closeOverlay();
      //       },
      //       onAcceptPressed: () async {
      //         print('Accept pressed, switching to second overlay');
      //         await FlutterOverlayWindow.closeOverlay();
      //         overlayMain2(); // Show second overlay
      //         await FlutterOverlayWindow.showOverlay(
      //           height: 1200,
      //           enableDrag: false,
      //           // alignment: OverlayAlignment.bottomRight,
      //           alignment: OverlayAlignment.centerRight,
      //           positionGravity: PositionGravity.auto,
      //         );
      //       },
      //     ),
      //   ],
      // ),

      ///
      home: OverlayWidgetBottom(
        onCancelPressed: () async {
          print('Driver cancelled the request');
          await FlutterOverlayWindow.closeOverlay();
        },
        onAcceptPressed: () async {
          print('Accept pressed, switching to second overlay');
          await FlutterOverlayWindow.closeOverlay();
          overlayMain2(); // Show second overlay
          await FlutterOverlayWindow.showOverlay(
            height: 1000,
            enableDrag: false,
            alignment: OverlayAlignment.centerLeft,
            positionGravity: PositionGravity.auto,
            visibility: NotificationVisibility.visibilityPublic,
            flag: OverlayFlag.defaultFlag,
          );
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

/// Second Overlay (Appears at Top)
@pragma("vm:entry-point")
void overlayMain2() {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter bindings are initialized
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
          _launchGoogleMapAppView();
          // launchGoogleMapsPiP();
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

/// --- Launch Google Map Started --- ///

/// 1. Launch Google Map and start navigation in its full app view.
// // Using url_launcher
// Future<void> _launchGoogleMap({required String origin, required String destination}) async {
//   final Uri googleMapUrl = Uri.parse("https://www.google.com/maps/dir/?api=1&origin=$origin&destination=$destination&dir_action=navigate&travelmode=driving");
//
//   if (await canLaunchUrl(googleMapUrl)) {
//     await launchUrl(googleMapUrl, mode: LaunchMode.platformDefault);
//   } else {
//     debugPrint("Could not launch Google Maps");
//   }
// }

/// 2. Launch Google Map and start navigation in its full app view.
// // Using android_intent_plus
void _launchGoogleMapAppView() {
  final intent = AndroidIntent(
    action: 'action_view',
    data: "google.navigation:q=26.7324,88.4176&mode=d",
    package: 'com.google.android.apps.maps',
    flags: [Flag.FLAG_ACTIVITY_NEW_TASK],
  );

  intent.launch();
}

/// 3. Launching Google Map and start navigation in Mini Window Mode/Picture-in-Picture (PiP) Mode
// // Using android_intent_plus
// Future<void> launchGoogleMapsPiP() async {
//   try {
//     final intent = AndroidIntent(
//       action: 'action_view',
//       data: 'google.navigation:q=26.7324,88.4176&mode=d',
//       package: 'com.google.android.apps.maps',
//     );
//
//     await intent.launch();
//
//     // Simulate pressing the Home button after a delay to trigger PiP mode
//     await Future.delayed(Duration(seconds: 2));
//     await _triggerPiPMode();
//   } on PlatformException catch (e) {
//     print("Error launching Google Maps: $e");
//   }
// }
//
// Future<void> _triggerPiPMode() async {
//   final intent = AndroidIntent(
//     action: 'android.intent.action.MAIN',
//     category: 'android.intent.category.HOME',
//   );
//
//   await intent.launch();
// }

/// --- Launch Google Map Ended --- ///

/// workmanager Method to show overlay from background state of app
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    print("Background Task Triggered: $task");
    showFirstOverlay();

    return Future.value(true);
  });
}

/// First Overlay (Appears at bottom after 10 seconds when app goes to background state)
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
  Timer(Duration(seconds: 30), () async {
    await FlutterOverlayWindow.closeOverlay();
    print('showFirstOverlay removed, 30 seconds completed');
  });
}

/// Remove Overlay
Future<void> removeOverlay() async {
  await FlutterOverlayWindow.closeOverlay();
  print('Overlay closed');
}

/// Main APP ()
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FlutterOverlayScreen(),
    );
  }
}
