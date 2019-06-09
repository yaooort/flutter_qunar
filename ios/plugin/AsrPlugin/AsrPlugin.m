//
//  AsrPlugin.m
//  Runner
//
//  Created by yao on 2019/6/9.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import "AsrPlugin.h"
#import "AsrManager.h"
@interface AsrPlugin()
@property (strong,nonatomic)AsrManager *asrManager;

@property (strong,nonatomic)FlutterResult asrFlutterResult;

@end
@implementation AsrPlugin

+(void) registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar{
    FlutterMethodChannel *channel = [FlutterMethodChannel methodChannelWithName:@"asr_baidu_channel" binaryMessenger:[registrar messenger]];
    AsrPlugin *asrPlugin = [AsrPlugin new];
    [registrar addMethodCallDelegate:asrPlugin channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result{
    if([@"start" isEqualToString:call.method]){
        self.asrFlutterResult = result;
        [self.asrManager start];
    }else if([@"stop" isEqualToString:call.method]){
        [self.asrManager stop];
    }else if([@"cancel" isEqualToString:call.method]){
        [self.asrManager cancel];
    }else{
        result(FlutterMethodNotImplemented);
    }
    
}

-(AsrManager*)asrManager{
    if(!_asrManager){
        _asrManager = [AsrManager initWith:^(NSString * _Nonnull message) {
            if(self.asrFlutterResult){
                self.asrFlutterResult(message);
                self.asrFlutterResult = nil;
            }
        } :^(NSString * _Nonnull message) {
            if(self.asrFlutterResult){
                self.asrFlutterResult([FlutterError errorWithCode:@"失败" message:message details:nil]);
                self.asrFlutterResult = nil;
            }
        }];
    }
    return _asrManager;
}


@end
