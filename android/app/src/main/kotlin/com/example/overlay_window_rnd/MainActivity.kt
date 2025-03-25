//package com.example.overlay_window_rnd
//
//import io.flutter.embedding.android.FlutterActivity
//
//class MainActivity: FlutterActivity()


package com.example.overlay_window_rnd

import android.content.Intent
import android.os.Build
import android.os.Bundle
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val CHANNEL = "chat_head"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "startChatHead" -> {
                    startChatHeadService()
                    result.success("Chat Head started")
                }
                "stopChatHead" -> {
                    stopChatHeadService()
                    result.success("Chat Head stopped")
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun startChatHeadService() {
        val intent = Intent(this, ChatHeadService::class.java)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            startForegroundService(intent)
        } else {
            startService(intent)
        }
    }

    private fun stopChatHeadService() {
        val intent = Intent(this, ChatHeadService::class.java)
        stopService(intent)
    }
}

