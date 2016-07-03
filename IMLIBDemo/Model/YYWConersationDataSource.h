//
//  YYWConersationModel.h
//  IMLIBDemo
//
//  Created by apple on 16/5/12.
//  Copyright © 2016年 ZDH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Foundation/Foundation.h>
#import "MessageModel.h"
#import "TextMessageModel.h"
#import "PhotoMessageModel.h"
#import "VideoMessageModel.h"
#import "VoiceMessageModel.h"
#import "LocationMessageModel.h"

@interface YYWConersationDataSource : NSObject

/**
 *  获取自定义的模型数组
 *
 *  @param messageArray RCMessageModel
 *  @param voicePath    localVocePath
 *  @param isGif        GIF or not
 *
 *  @return <#return value description#>
 */
+ (NSMutableArray *)getMessageArrayWithRCMessageArray:(NSArray *)messageArray
                                            voicePath:(NSString *)voicePath;
@end
