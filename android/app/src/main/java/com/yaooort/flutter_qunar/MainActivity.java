package com.yaooort.flutter_qunar;

import android.os.Bundle;

import com.yaooort.baidu_asr.plugin.AsrPlugin;

import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);

        //注册自己创建的插件
        registerSelfPlugin();
    }

    private void registerSelfPlugin() {

        AsrPlugin.registerWith(registrarFor("com.yaooort.baidu_asr.plugin.AsrPlugin"));
    }
}