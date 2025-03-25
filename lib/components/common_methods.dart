import 'dart:async';
import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

/// Temporary URL for launching google map
const String kGoogleMapUrl =
    "https://www.google.com/maps/dir/?api=1&origin=18.6370204,73.8244481&destination=26.7324,88.4176&dir_action=navigate&travelmode=driving";

/// Static Latitude & Longitude
const double originLatitude = 18.6370204;
const double originLongitude = 73.8244481;

const double destinationLatitude = 26.7324;
const double destinationLongitude = 88.4176;

/// Common Methods
class CommonMethods {
  static const platform = MethodChannel('chat_head');

  /// Request Overlay Permission
  static Future<void> requestOverlayPermission() async {
    bool? granted = await FlutterOverlayWindow.isPermissionGranted();
    if (granted == false) {
      await FlutterOverlayWindow.requestPermission();
    }
  }

  /// Start Bubble_Chat_Head Overlay
  static Future<void> startChatHead() async {
    try {
      await platform.invokeMethod('startChatHead');
    } on PlatformException catch (e) {
      print("Failed to start chat head: ${e.message}");
    }
  }

  /// Remove Bubble_Chat_Head Overlay
  static Future<void> stopChatHead() async {
    try {
      await platform.invokeMethod('stopChatHead');
    } on PlatformException catch (e) {
      print("Failed to stop chat head: ${e.message}");
    }
  }

  /// First Overlay (Appears at bottom after 10 seconds when app goes to background state)
  static Future<void> showFirstOverlay() async {
    await FlutterOverlayWindow.showOverlay(
      height: 1500,
      enableDrag: false,
      alignment: OverlayAlignment.bottomCenter,
      positionGravity: PositionGravity.auto,
      visibility: NotificationVisibility.visibilityPublic,
      flag: OverlayFlag.defaultFlag,
    );

    // If user doesn't accept within 30 seconds, remove the overlay
    Timer(Duration(seconds: 30), () {
      closeOverlay();
      print('showFirstOverlay removed, 30 seconds completed');
    });
  }

  /// Remove Overlay
  static Future<void> closeOverlay() async {
    await FlutterOverlayWindow.closeOverlay();
    print('Overlay closed');
  }

  /// If user doesn't accept within 30 seconds, remove the overlay
  static Future<void> removeOverlayAfter30Sec() async {
    Timer(Duration(seconds: 30), () async {
      closeOverlay();
      print('Overlay removed, 30 seconds completed');
    });
  }

  // --- Send data Start --- //
  /// 1. Send data from main app to overlay using FlutterOverlayWindow methods
  static Future<void> sendDataToOverlay(String value) async {
    await FlutterOverlayWindow.shareData(value);
  }

  /// 2. Send data from main app to overlay using SharedPreferences
  static Future<void> sendValueToOverlay(String valueToPass) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('overlay_message', valueToPass);
  }

  /// 3. Sending Pickup & Drop Location dynamically from main app to overlay using SharedPreferences
  static Future<void> sendValueToOverlay2({
    required String pickupLocation,
    required String dropLocation,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('pickup_location', pickupLocation);
    await prefs.setString('drop_location', dropLocation);
  }

  // --- Send data End --- //

  /// Listen to the data from main app
  /*
  Future<String> receiveOverlayData(data) async {
    final prefs = await SharedPreferences.getInstance();
    data = prefs.getString('overlay_message') ?? "No data passed";
    return data;
  }
  */

  // --- Launch Google Map Started --- //
  /// 1. Launch Google Map and start navigation in its full app view.
  // // Using url_launcher
  // static Future<void> _launchGoogleMap({required String origin, required String destination}) async {
  //   final Uri googleMapUrl =
  //       Uri.parse("https://www.google.com/maps/dir/?api=1&origin=$origin&destination=$destination&dir_action=navigate&travelmode=driving");
  //
  //   if (await canLaunchUrl(googleMapUrl)) {
  //     await launchUrl(googleMapUrl, mode: LaunchMode.platformDefault);
  //   } else {
  //     print("Could not launch Google Maps");
  //   }
  // }

  /// 2. Launch Google Map and start navigation in its full app view.
  // Using android_intent_plus
  static void launchGoogleMapAppView() {
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
  // static Future<void> launchGoogleMapsPiP() async {
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
  // static Future<void> _triggerPiPMode() async {
  //   final intent = AndroidIntent(
  //     action: 'android.intent.action.MAIN',
  //     category: 'android.intent.category.HOME',
  //   );
  //
  //   await intent.launch();
  // }

  /// --- Launch Google Map Ended --- ///
}

/// Constant's
const kText18w400 = TextStyle(
  fontSize: 18,
  color: Colors.white,
  fontWeight: FontWeight.w400,
);
const kText14w400 = TextStyle(
  fontSize: 14,
  color: Colors.white,
  fontWeight: FontWeight.w400,
);
const kHeightGap10 = SizedBox(height: 10);
const kHeightGap20 = SizedBox(height: 20);
const kHeightGap30 = SizedBox(height: 30);
