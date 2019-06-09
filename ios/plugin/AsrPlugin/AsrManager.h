//
//  AsrManager.h
//  Runner
//
//  Created by yao on 2019/6/9.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AsrManager : NSObject

typedef void(^AsrCallBack)(NSString* message);

+ (instancetype)initWith:(AsrCallBack) success :(AsrCallBack) faliure;
-(void)start;
-(void)stop;
-(void)cancel;
@end

NS_ASSUME_NONNULL_END
