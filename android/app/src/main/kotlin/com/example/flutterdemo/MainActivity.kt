package com.example.flutterdemo

import android.content.Intent
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.util.Log
import android.widget.Toast
import com.haima.hmcp.HmcpManager
import com.haima.hmcp.listeners.OnInitCallBackListener
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val tag = "MainActivity"
    private lateinit var methodReceiveChannel: MethodChannel
    private lateinit var methodSendChannel: MethodChannel
    private var initSuccess = false

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

    }
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        methodReceiveChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "PlatformReceive")
        methodReceiveChannel.setMethodCallHandler { call, result ->
            run {
                Toast.makeText(this@MainActivity, "call  ${call.method}", Toast.LENGTH_SHORT).show()
                when (call.method) {
                    "getContent" -> result.success(getContent())
                    "goOther" ->{
                        if(initSuccess)
                            startActivity(Intent(this@MainActivity,OtherActivity::class.java))
                        else
                            showToast("not init")
                    }
                }
            }
        }


        methodSendChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "FlutterReceive")

    }

    private fun showToast(msg:String){
        Toast.makeText(this@MainActivity, msg, Toast.LENGTH_SHORT).show()
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
