package com.example.integrations

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.widget.TextView
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {

    private val androidViewId = "INTEGRATION_ANDROID"
    private val methodChannelId = "CALL_METHOD"
    private val intentMessageId = "CALL"
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        flutterEngine
            .platformViewsController
            .registry
            .registerViewFactory(androidViewId, NativeViewFactory())

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, methodChannelId).setMethodCallHandler {
                call, result ->
            if (call.method == intentMessageId) {
                val textView = findViewById<TextView>(0)
                val message = call.argument("text") ?: ""
                if (textView != null) {
                    textView.text = message
                    textView.refreshDrawableState()
                }
            } else {
                result.notImplemented()
            }
        }
    }

}
