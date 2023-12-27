package com.example.flutterdemo

import android.app.Application
import io.flutter.embedding.engine.loader.FlutterLoader

/***
 * @author ： 于德海
 * time ： 2023/12/27 19:10
 * desc ：
 */
public class FlutterDemoApplication : Application(){

    override fun onCreate() {
        super.onCreate()
        FlutterLoader().initialized()
    }
}