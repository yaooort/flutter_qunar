import 'package:flutter/services.dart';

class AsrManager {
  //初始化通信桥梁
  static const MethodChannel _channel =
      const MethodChannel('asr_baidu_channel');

  //开始录音
  static Future<String> start({Map pargms}) async {
    return await _channel.invokeMethod('start');
  }

  //停止录音
  static Future<String> stop() async {
    return await _channel.invokeMethod('stop');
  }

  //取消录音
  static Future<String> cancel() async {
    return await _channel.invokeMethod('cancel');
  }
}
