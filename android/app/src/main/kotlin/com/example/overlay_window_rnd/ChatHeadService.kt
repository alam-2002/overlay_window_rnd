package com.example.overlay_window_rnd

import android.app.Service
import android.content.Context
import android.content.Intent
import android.graphics.PixelFormat
import android.os.Build
import android.os.IBinder
import android.view.Gravity
import android.view.LayoutInflater
import android.view.MotionEvent
import android.view.View
import android.view.WindowManager
import android.widget.ImageView
import android.app.NotificationChannel
import android.app.NotificationManager
import androidx.core.app.NotificationCompat


class ChatHeadService : Service() {

    private lateinit var windowManager: WindowManager
    private lateinit var chatHeadView: View

    override fun onCreate() {
        super.onCreate()

        // Start foreground service with notification
        startForegroundService()

        // Initialize WindowManager
        windowManager = getSystemService(Context.WINDOW_SERVICE) as WindowManager
        val inflater = getSystemService(Context.LAYOUT_INFLATER_SERVICE) as LayoutInflater
        chatHeadView = inflater.inflate(R.layout.chat_head_layout, null)

        val layoutParams = WindowManager.LayoutParams(
            WindowManager.LayoutParams.WRAP_CONTENT,
            WindowManager.LayoutParams.WRAP_CONTENT,
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O)
                WindowManager.LayoutParams.TYPE_APPLICATION_OVERLAY
            else
                WindowManager.LayoutParams.TYPE_PHONE,
            WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE,
            PixelFormat.TRANSLUCENT
        )

        layoutParams.gravity = Gravity.TOP or Gravity.START
        layoutParams.x = 100
        layoutParams.y = 100

        // Chat head image (Make sure it's present in `res/drawable`)
        val chatHeadImage = chatHeadView.findViewById<ImageView>(R.id.chat_head_icon)

        chatHeadImage.setOnTouchListener(object : View.OnTouchListener {
            private var initialX = 0
            private var initialY = 0
            private var touchX = 0f
            private var touchY = 0f

            override fun onTouch(v: View?, event: MotionEvent): Boolean {
                when (event.action) {
                    MotionEvent.ACTION_DOWN -> {
                        initialX = layoutParams.x
                        initialY = layoutParams.y
                        touchX = event.rawX
                        touchY = event.rawY
                        return true
                    }
                    MotionEvent.ACTION_MOVE -> {
                        layoutParams.x = initialX + (event.rawX - touchX).toInt()
                        layoutParams.y = initialY + (event.rawY - touchY).toInt()
                        windowManager.updateViewLayout(chatHeadView, layoutParams)
                        return true
                    }
                }
                return false
            }
        })

        // Add chat head to the window
        windowManager.addView(chatHeadView, layoutParams)
    }

    private fun startForegroundService() {
        val channelId = "chat_head_service_channel"
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                channelId,
                "Chat Head Service",
                NotificationManager.IMPORTANCE_LOW
            )
            val manager = getSystemService(NotificationManager::class.java)
            manager.createNotificationChannel(channel)
        }

        val notification = NotificationCompat.Builder(this, channelId)
            .setContentTitle("Chat Head Active")
            .setContentText("Your chat head is running in the background.")
            .setSmallIcon(R.drawable.ic_chat_head)  // Make sure this icon exists in `res/drawable`
            .build()

        startForeground(1, notification)
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        return START_STICKY
    }

    override fun onDestroy() {
        super.onDestroy()
        windowManager.removeView(chatHeadView)
    }

    override fun onBind(intent: Intent?): IBinder? {
        return null
    }
}




////package com.example.bubble_chat_head_like_fb
//package com.example.overlay_window_rnd
//
//import android.app.Service
//import android.content.Context
//import android.content.Intent
//import android.graphics.PixelFormat
//import android.os.Build
//import android.os.IBinder
//import android.view.Gravity
//import android.view.LayoutInflater
//import android.view.MotionEvent
//import android.view.View
//import android.view.WindowManager
//import android.widget.ImageView
//
//class ChatHeadService : Service() {
//
//    private lateinit var windowManager: WindowManager
//    private lateinit var chatHeadView: View
//
//    override fun onCreate() {
//        super.onCreate()
//
//        // Initialize WindowManager
//        windowManager = getSystemService(Context.WINDOW_SERVICE) as WindowManager
//
//        // Inflate the chat head layout
//        val inflater = getSystemService(Context.LAYOUT_INFLATER_SERVICE) as LayoutInflater
//        chatHeadView = inflater.inflate(R.layout.chat_head_layout, null)
//
//        // Reference the ImageView inside chat_head_layout.xml
//        val chatHeadImage = chatHeadView.findViewById<ImageView>(R.id.ic_chat_head)
//
//        // Chat head layout parameters
//        val layoutParams = WindowManager.LayoutParams(
//            WindowManager.LayoutParams.WRAP_CONTENT,
//            WindowManager.LayoutParams.WRAP_CONTENT,
//            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O)
//                WindowManager.LayoutParams.TYPE_APPLICATION_OVERLAY
//            else
//                WindowManager.LayoutParams.TYPE_PHONE,
//            WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE,
//            PixelFormat.TRANSLUCENT
//        )
//
//        layoutParams.gravity = Gravity.TOP or Gravity.START
//        layoutParams.x = 100
//        layoutParams.y = 100
//
//        // Make the chat head draggable
//        chatHeadImage.setOnTouchListener(object : View.OnTouchListener {
//            private var initialX = 0
//            private var initialY = 0
//            private var touchX = 0f
//            private var touchY = 0f
//
//            override fun onTouch(v: View?, event: MotionEvent): Boolean {
//                when (event.action) {
//                    MotionEvent.ACTION_DOWN -> {
//                        initialX = layoutParams.x
//                        initialY = layoutParams.y
//                        touchX = event.rawX
//                        touchY = event.rawY
//                        return true
//                    }
//                    MotionEvent.ACTION_MOVE -> {
//                        layoutParams.x = initialX + (event.rawX - touchX).toInt()
//                        layoutParams.y = initialY + (event.rawY - touchY).toInt()
//                        windowManager.updateViewLayout(chatHeadView, layoutParams)
//                        return true
//                    }
//                }
//                return false
//            }
//        })
//
//        // Add the chat head view to the window
//        windowManager.addView(chatHeadView, layoutParams)
//    }
//
//    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
//        return START_STICKY
//    }
//
//    override fun onDestroy() {
//        super.onDestroy()
//        windowManager.removeView(chatHeadView)
//    }
//
//    override fun onBind(intent: Intent?): IBinder? {
//        return null
//    }
//}
