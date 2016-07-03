//
//  YYWIMChatListCell.h
//  IMLIBDemo
//
//  Created by apple on 16/5/11.
//  Copyright © 2016年 ZDH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYWIMChatListCell : UITableViewCell

// 未读的消息
- (void) loadUreadNumber:(int) count;
// 名称
- (void) loadUserName:(NSString *)name;
// 加载最后一条信息
- (void) loadLastMessage:(NSString *)mes;
// 加载消息的时间
- (void) loadLastMessageTime:(NSString *)time;
// 加载回话头像
- (void) loadChatListHeadImageUrl:(NSString *)headerViewUrl;


@end
