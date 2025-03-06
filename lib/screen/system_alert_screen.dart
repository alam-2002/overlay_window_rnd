import 'dart:async';
import 'package:flutter/material.dart';
import 'package:overlay_window_rnd/components/overlay_widget_bottom.dart';
import 'package:system_alert_window/system_alert_window.dart';

class SystemAlertScreen extends StatefulWidget {
  const SystemAlertScreen({super.key});

  @override
  State<SystemAlertScreen> createState() => _SystemAlertScreenState();
}

class _SystemAlertScreenState extends State<SystemAlertScreen> {
  bool? isGranted;

  Future<void> startOverlay() async {
    await SystemAlertWindow.showSystemWindow(
      height: 450,
      // width: 50,
      prefMode: SystemWindowPrefMode.OVERLAY,
      gravity: SystemWindowGravity.BOTTOM,
    );

    Timer(Duration(seconds: 15), () {
      removeOverlay();
    });
  }

  Future<void> removeOverlay() async {
    await SystemAlertWindow.closeSystemWindow();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("system_alert_window")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                isGranted = await SystemAlertWindow.requestPermissions();
              },
              child: const Text("Request Overlay Permission"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (isGranted == false) {
                  await SystemAlertWindow.requestPermissions();
                } else {
                  startOverlay();
                }
              },
              child: const Text("Show Overlay"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await SystemAlertWindow.closeSystemWindow();
              },
              child: const Text("Close Overlay"),
            ),
            // OverlayWidget(),
            // ChatHeadOverlay(),
            // OverlayWidgetOne(),
          ],
        ),
      ),
    );
  }
}
