package com.example.flutterdemo

import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.os.PersistableBundle
import android.util.Log
import android.widget.Toast
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private lateinit var methodReceiveChannel: MethodChannel
    private lateinit var methodSendChannel: MethodChannel

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        methodReceiveChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "PlatformReceive")
        methodReceiveChannel.setMethodCallHandler { call, result ->
            run {
                Toast.makeText(this@MainActivity, "call  ${call.method}", Toast.LENGTH_SHORT).show()
                when (call.method) {
                    "getContent" -> result.success(getContent())
                }
            }
        }


        methodSendChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "FlutterReceive")

    }


    private fun getContent(): String {

        Handler(Looper.getMainLooper()).postDelayed(Runnable {
            callFlutterMethod()
        }, 1000)
        return "HelloWorld"
    }


    private fun callFlutterMethod() {
        methodSendChannel.invokeMethod("changeCount",100,object : MethodChannel.Result{
            override fun notImplemented() {
            }

            override fun error(errorCode: String, errorMessage: String?, errorDetails: Any?) {
                Log.e("Main","Error $errorCode $errorMessage $errorDetails")
                Toast.makeText(this@MainActivity, "error $errorMessage", Toast.LENGTH_SHORT).show()
            }

            override fun success(result: Any?) {

                Toast.makeText(this@MainActivity, "success", Toast.LENGTH_SHORT).show()
            }})
    }
}
