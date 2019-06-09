//
//  AsrManager.m
//  Runner
//
//  Created by yao on 2019/6/9.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import "AsrManager.h"
#import "BDSEventManager.h"
#import "BDSASRDefines.h"
#import "BDSASRParameters.h"

const NSString* APP_ID = @"16462247";
const NSString* API_KEY = @"UnTNir0WYttcAkXLih19r8pV";
const NSString* SECRET_KEY = @"XxoG6k9Ptv5u7CgB6dWGKSlnw4bEaTyB";


@interface AsrManager()<BDSClientASRDelegate>

@property (strong,nonatomic) BDSEventManager *asrBDSEventManager;

@property (copy,nonatomic) AsrCallBack asrSuccess;

@property (copy,nonatomic) AsrCallBack asrFaliure;

@end
@implementation AsrManager

+ (instancetype)initWith:(AsrCallBack) success :(AsrCallBack) faliure{
    AsrManager *manager = [AsrManager new];
    manager.asrFaliure = faliure;
    manager.asrSuccess = success;
    return manager;
}

-(instancetype) init{
    if([super init]){
        self.asrBDSEventManager = [BDSEventManager createEventManagerWithName:BDS_ASR_NAME];
        [self configVoiceRecognitionClient];
    }
    return self;
}

-(void)start{
    [self.asrBDSEventManager setParameter:@(NO) forKey:BDS_ASR_NEED_CACHE_AUDIO];
    [self.asrBDSEventManager setDelegate:self];
    [self.asrBDSEventManager setParameter:nil forKey:BDS_ASR_AUDIO_INPUT_STREAM];
    [self.asrBDSEventManager setParameter:@"" forKey:BDS_ASR_AUDIO_FILE_PATH];
    [self.asrBDSEventManager sendCommand:BDS_ASR_CMD_START];
}
-(void)stop{
    
    [self.asrBDSEventManager sendCommand:BDS_ASR_CMD_STOP];
    
}
-(void)cancel{
    [self.asrBDSEventManager sendCommand:BDS_ASR_CMD_CANCEL];
}

#pragma mark - MVoiceRecognitionClientDelegate

- (void)VoiceRecognitionClientWorkStatus:(int)workStatus obj:(id)aObj {
    switch (workStatus) {
        case EVoiceRecognitionClientWorkStatusNewRecordData: {
            
            break;
        }
            
        case EVoiceRecognitionClientWorkStatusStartWorkIng: {
           
            break;
        }
        case EVoiceRecognitionClientWorkStatusStart: {
            
            break;
        }
        case EVoiceRecognitionClientWorkStatusEnd: {
            
            break;
        }
        case EVoiceRecognitionClientWorkStatusFlushData: {
            
            break;
        }
        case EVoiceRecognitionClientWorkStatusFinish: {
            // 语音识别功能完成，服务器返回正确结果
            NSString *jieguo = [self getDescriptionForDic:aObj];
            if(self.asrSuccess){
                self.asrSuccess(jieguo);
            }
            break;
        }
        case EVoiceRecognitionClientWorkStatusMeterLevel: {
            break;
        }
        case EVoiceRecognitionClientWorkStatusCancel: {
            
            break;
        }
        case EVoiceRecognitionClientWorkStatusError: {
            // 发生错误
            if(self.asrFaliure){
                self.asrFaliure([NSString stringWithFormat:@"CALLBACK: encount error - %@.\n", (NSError *)aObj]);
            }
            break;
        }
        case EVoiceRecognitionClientWorkStatusLoaded: {
            
            break;
        }
        case EVoiceRecognitionClientWorkStatusUnLoaded: {
            
            break;
        }
        case EVoiceRecognitionClientWorkStatusChunkThirdData: {
            
            break;
        }
        case EVoiceRecognitionClientWorkStatusChunkNlu: {
            
            break;
        }
        case EVoiceRecognitionClientWorkStatusChunkEnd: {
            
            break;
        }
        case EVoiceRecognitionClientWorkStatusFeedback: {
           
            break;
        }
        case EVoiceRecognitionClientWorkStatusRecorderEnd: {
            
            break;
        }
        case EVoiceRecognitionClientWorkStatusLongSpeechEnd: {
            
            break;
        }
        default:
            break;
    }
}
- (NSString *)getDescriptionForDic:(NSDictionary *)dic {
    if (dic) {
        return [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:dic
                                                                        options:NSJSONWritingPrettyPrinted
                                                                                error:nil] encoding:NSUTF8StringEncoding];
    }
    return nil;
}
#pragma mark - Private: Configuration

- (void)configVoiceRecognitionClient {
    //设置DEBUG_LOG的级别
    [self.asrBDSEventManager setParameter:@(EVRDebugLogLevelTrace) forKey:BDS_ASR_DEBUG_LOG_LEVEL];
    //配置API_KEY 和 SECRET_KEY 和 APP_ID
    [self.asrBDSEventManager setParameter:@[API_KEY, SECRET_KEY] forKey:BDS_ASR_API_SECRET_KEYS];
    [self.asrBDSEventManager setParameter:APP_ID forKey:BDS_ASR_OFFLINE_APP_CODE];
    //配置端点检测（二选一）
    [self configModelVAD];
    //    [self configDNNMFE];
    
    //    [self.asrEventManager setParameter:@"15361" forKey:BDS_ASR_PRODUCT_ID];
    // ---- 语义与标点 -----
    //    [self enableNLU];
    //    [self enablePunctuation];
    // ------------------------
    
    //---- 语音自训练平台 ----
    //    [self configSmartAsr];
}


- (void)configModelVAD {
    NSString *modelVAD_filepath = [[NSBundle mainBundle] pathForResource:@"bds_easr_basic_model" ofType:@"dat"];
    [self.asrBDSEventManager setParameter:modelVAD_filepath forKey:BDS_ASR_MODEL_VAD_DAT_FILE];
    [self.asrBDSEventManager setParameter:@(YES) forKey:BDS_ASR_ENABLE_MODEL_VAD];
}
@end
