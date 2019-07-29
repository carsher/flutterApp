package com.example.flutter_app

import android.os.Bundle
import com.example.asr_plugin.devio.flutter.asr.AsrPlugin

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)
   registerSelfPlugin();
  }

  private fun registerSelfPlugin() {
    AsrPlugin.registerWith(registrarFor("com.example.asr_plugin.devio.flutter.asr.AsrPlugin"));
  }
}
