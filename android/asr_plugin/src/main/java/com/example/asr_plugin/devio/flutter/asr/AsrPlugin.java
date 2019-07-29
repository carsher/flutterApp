package com.example.asr_plugin.devio.flutter.asr;

import android.Manifest;
import android.app.Activity;
import android.content.pm.PackageManager;
import android.util.Log;

import java.util.ArrayList;
import java.util.Map;

import androidx.annotation.Nullable;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

public class AsrPlugin implements MethodChannel.MethodCallHandler {
    private final static String TAG = "AsrPlugin";
    private final Activity activity;
    private AsrManager asrManager;
    private ResultStateful resultStateful;

    public static void registerWith(PluginRegistry.Registrar registrar){
        MethodChannel methodChannel = new MethodChannel(registrar.messenger(),"asr_plugin");
        AsrPlugin asrPlugin = new AsrPlugin(registrar);
        methodChannel.setMethodCallHandler(asrPlugin);
    }

    public AsrPlugin(PluginRegistry.Registrar registrar) {
        this.activity = registrar.activity();
    }

    @Override
    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
        initPermission();
        switch (methodCall.method) {
            case "start":
                resultStateful = ResultStateful.of(result);
                start(methodCall, resultStateful);
                break;
            case "stop":
                stop(methodCall,result);
                break;
            case "cancel":
                cancel(methodCall,result);
                break;
            default:
                result.notImplemented();
        }

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

    private void cancel(MethodCall methodCall, MethodChannel.Result result) {
        if (asrManager!=null){
            asrManager.cancel();
        }
    }

    private void stop(MethodCall methodCall, MethodChannel.Result result) {
        if (asrManager!=null){
            asrManager.stop();
        }
    }

    private void start(MethodCall methodCall, ResultStateful resultStateful) {
        if (activity == null){
            Log.e(TAG,"msg:Ignord start,current activity is null");
            resultStateful.error("msg:Ignord start,current activity is null",null,null);
            return;
        }
        if (getAsrMAnager()!=null){
            getAsrMAnager().start(methodCall.arguments instanceof Map?(Map)methodCall.arguments:null);
        }else {
            Log.e(TAG,"msg:Ignord start,current activity is null");
            resultStateful.error("msg:Ignord start,current activity is null",null,null);
        }
    }
    @Nullable
    private AsrManager getAsrMAnager(){
        if (asrManager == null){
            if (activity!=null && !activity.isFinishing()){
                asrManager = new AsrManager(activity,onAsrListener);
            }
        }
        return asrManager;
    }
    private OnAsrListener onAsrListener = new OnAsrListener() {
        @Override
        public void onAsrReady() {


        }

        @Override
        public void onAsrBegin() {

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
            if (recogResult!=null){
                resultStateful.success(results[0]);
            }
        }

        @Override
        public void onAsrFinish(RecogResult recogResult) {

        }

        @Override
        public void onAsrFinishError(int errorCode, int subErrorCode, String descMessage, RecogResult recogResult) {
            if (recogResult!=null){
                resultStateful.error(descMessage,null,null);
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
