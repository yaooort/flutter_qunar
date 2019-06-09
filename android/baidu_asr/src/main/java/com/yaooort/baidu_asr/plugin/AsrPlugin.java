package com.yaooort.baidu_asr.plugin;

import android.Manifest;
import android.app.Activity;
import android.content.pm.PackageManager;

import androidx.annotation.Nullable;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import com.yaooort.baidu_asr.MyLogger;
import com.yaooort.baidu_asr.baidu_ai.MyRecognizer;
import com.yaooort.baidu_asr.baidu_ai.RecogResult;
import com.yaooort.baidu_asr.baidu_ai.listener.IRecogListener;
import com.yaooort.baidu_asr.plugin.asr.ResultStateful;

import java.util.ArrayList;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

public class AsrPlugin implements MethodChannel.MethodCallHandler {

    private final Activity activity;
    private ResultStateful resultStateful;

    private MyRecognizer myRecognizer;

    public AsrPlugin(PluginRegistry.Registrar registrar) {
        this.activity = registrar.activity();
    }

    /**
     * 注册
     *
     * @param registrar
     */
    public static void registerWith(PluginRegistry.Registrar registrar) {
//        注册方法
        MethodChannel channel = new MethodChannel(registrar.messenger(), "asr_baidu_channel");
        AsrPlugin asrPlugin = new AsrPlugin(registrar);
        channel.setMethodCallHandler(asrPlugin);
    }

    @Override
    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
        switch (methodCall.method) {
            case "start":
                resultStateful = ResultStateful.of(result);
                start(methodCall, resultStateful);
                break;
            case "stop":
                stop(methodCall, resultStateful);
                break;
            case "cancel":
                cancel(methodCall, resultStateful);
                break;
            default:
//                为实现
                result.notImplemented();
        }
    }

    private void start(MethodCall methodCall, ResultStateful resultStateful) {
        if (activity == null) {
            resultStateful.error("Activity为空", null, null);
            return;
        }
        if (getMyRecognizer() != null) {
            getMyRecognizer().start(methodCall.arguments instanceof Map ? (Map) methodCall.arguments : null);
        } else {
            MyLogger.error("出错了");
            resultStateful.error("调用原生出错", null, null);
        }
    }

    private void stop(MethodCall methodCall, ResultStateful resultStateful) {
        if (myRecognizer != null) {
            myRecognizer.stop();
        }
    }

    private void cancel(MethodCall methodCall, ResultStateful resultStateful) {
        if (myRecognizer != null) {
            myRecognizer.cancel();
        }
    }

    @Nullable
    private MyRecognizer getMyRecognizer() {
        if (myRecognizer == null) {
            if (activity != null && activity.isFinishing()) {
                myRecognizer = new MyRecognizer(activity, iRecogListener);
            }
        }
        return myRecognizer;
    }

    /**
     * android 6.0 以上需要动态申请权限
     */
    private void initPermission() {
        String permissions[] = {Manifest.permission.RECORD_AUDIO,
                Manifest.permission.ACCESS_NETWORK_STATE,
                Manifest.permission.INTERNET,
                Manifest.permission.READ_PHONE_STATE,
                Manifest.permission.WRITE_EXTERNAL_STORAGE
        };

        ArrayList<String> toApplyList = new ArrayList<String>();

        for (String perm :permissions){
            if (PackageManager.PERMISSION_GRANTED != ContextCompat.checkSelfPermission(activity, perm)) {
                toApplyList.add(perm);
                //进入到这里代表没有权限.

            }
        }
        String tmpList[] = new String[toApplyList.size()];
        if (!toApplyList.isEmpty()){
            ActivityCompat.requestPermissions(activity, toApplyList.toArray(tmpList), 123);
        }

    }


    private IRecogListener iRecogListener = new IRecogListener() {
        @Override
        public void onAsrReady() {

        }

        @Override
        public void onAsrBegin() {
            initPermission();
        }

        @Override
        public void onAsrEnd() {

        }

        @Override
        public void onAsrPartialResult(String[] results, RecogResult recogResult) {

        }

        @Override
        public void onAsrOnlineNluResult(String nluResult) {

        }

        @Override
        public void onAsrFinalResult(String[] results, RecogResult recogResult) {
            if (resultStateful != null) {
                resultStateful.success(results[0]);
            }
        }

        @Override
        public void onAsrFinish(RecogResult recogResult) {

        }

        @Override
        public void onAsrFinishError(int errorCode, int subErrorCode, String descMessage, RecogResult recogResult) {
            if (resultStateful != null) {
                resultStateful.error(descMessage, null, null);
            }
        }

        @Override
        public void onAsrLongFinish() {

        }

        @Override
        public void onAsrVolume(int volumePercent, int volume) {

        }

        @Override
        public void onAsrAudio(byte[] data, int offset, int length) {

        }

        @Override
        public void onAsrExit() {

        }

        @Override
        public void onOfflineLoaded() {

        }

        @Override
        public void onOfflineUnLoaded() {

        }
    };
}
