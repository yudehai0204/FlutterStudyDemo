package com.example.flutterdemo

import android.app.Activity
import android.os.Bundle

/***
 * time ： 2023/12/27 20:40
 * desc ：
 */
class OtherActivity : Activity() {
    private val tag = "OtherActivity"
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        setContentView(R.layout.aty_player)

    }



}