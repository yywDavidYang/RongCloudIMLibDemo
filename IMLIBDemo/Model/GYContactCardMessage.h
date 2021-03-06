//
//  GYContactCardMessage.h
//  RongYunChatDemo
//
//  Created by apple on 16/3/5.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <RongIMLib/RongIMLib.h>

@interface GYContactCardMessage : RCMessageContent <NSCoding,RCMessageContentView>

/** 文本消息内容 */
@property(nonatomic, strong) NSString* content;

/**
 * 附加信息
 */
@property(nonatomic, strong) NSString* extra;

/**
 * 根据参数创建文本消息对象
 * @param content 文本消息内容
 */
+ (instancetype)messageWithContent:(NSString *)content;

@end
