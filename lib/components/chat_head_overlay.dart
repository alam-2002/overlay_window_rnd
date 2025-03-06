import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';

class ChatHeadOverlay extends StatelessWidget {
  const ChatHeadOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onPanUpdate: (details) {
          // Update the position of the chat-head overlay
          FlutterOverlayWindow.resizeOverlay(
            50,
            50,
            true,
          );
        },
        child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Center(
            child: Icon(
              Icons.chat,
              color: Colors.white,
              size: 25,
            ),
          ),
        ),
      ),
    );
  }
}
