package com.example.overlay_window_rnd

import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity()


//package com.example.overlay_window_rnd
//
//import android.app.PictureInPictureParams
//import android.os.Build
//import android.util.Rational
//import io.flutter.embedding.android.FlutterActivity
//import io.flutter.embedding.engine.FlutterEngine
//import io.flutter.plugin.common.MethodChannel
//
//class MainActivity: FlutterActivity() {
//    private val CHANNEL = "com.example.overlay_window_rnd/pip"
//
//    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
//        super.configureFlutterEngine(flutterEngine)
//        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
//            if (call.method == "triggerPiP") {
//                enterPiPMode()
//                result.success(null)
//            } else {
//                result.notImplemented()
//            }
//        }
//    }
//
//    private fun enterPiPMode() {
//        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
//            val aspectRatio = Rational(16, 9) // Adjust aspect ratio for PiP window
//            val params = PictureInPictureParams.Builder()
//                .setAspectRatio(aspectRatio)
//                .build()
//            enterPictureInPictureMode(params)
//        }
//    }
//}
