import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:workmanager/workmanager.dart';

const String taskName = "callApiTask";

class ApiCallScreen extends StatelessWidget {
  const ApiCallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("WorkManager API Call")),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              Workmanager().registerOneOffTask("uniqueTask", taskName);
              print("Background Task Scheduled!");
            },
            child: Text("Accept"),
          ),
        ),
      ),
    );
  }
}

// ====================================================================== //

/*

/// Main UI Screen
class MainScreen extends StatelessWidget {
  final TextEditingController textController = TextEditingController();

  Future<void> sendDataToOverlay(String value) async {
    await FlutterOverlayWindow.shareData(value);
  }

  Future<void> startOverlay() async {
    bool permission = await FlutterOverlayWindow.isPermissionGranted();

    if (!permission) {
      await FlutterOverlayWindow.requestPermission();
    }

    await FlutterOverlayWindow.showOverlay(
      enableDrag: true,
      height: 800,
      // width: 300,
      alignment: OverlayAlignment.center,
      overlayTitle: "Overlay Title",
      overlayContent: "Waiting for data...",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Overlay Window Demo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: textController,
              decoration: InputDecoration(
                labelText: 'Enter value to send to overlay',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await startOverlay();
              },
              child: Text('Start Overlay'),
            ),
            ElevatedButton(
              onPressed: () {
                final value = textController.text;
                sendDataToOverlay(value);
              },
              child: Text('Send Value to Overlay'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Overlay Widget
class OverlayApp extends StatefulWidget {
  @override
  State<OverlayApp> createState() => _OverlayAppState();
}

class _OverlayAppState extends State<OverlayApp> {
  String overlayValue = "Waiting for data...";

  @override
  void initState() {
    super.initState();

    // Listen to shared data from main app
    FlutterOverlayWindow.overlayListener.listen((data) {
      print("Overlay received: $data");
      setState(() {
        overlayValue = data.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Material(
        color: Colors.black.withOpacity(0.7),
        child: Center(
          child: Container(
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Overlay Message:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 10),
                Text(
                  overlayValue,
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
*/
