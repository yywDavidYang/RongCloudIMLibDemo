//
//  YYWIMChatListViewController.m
//  IMLIBDemo
//
//  Created by apple on 16/5/11.
//  Copyright © 2016年 ZDH. All rights reserved.
//

#import "YYWIMChatListViewController.h"
#import <RongIMLib/RongIMLib.h>
#import "ChatCollectionViewController.h"
#import "YYWIMChatListCell.h"
#import "Masonry.h"

@interface YYWIMChatListViewController ()<RCIMClientReceiveMessageDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray *conversationList;
@property (nonatomic,strong) UITableView *tableView;

@end

@implementation YYWIMChatListViewController

static NSString * cellID = @"MyCell";

#pragma mark CreateUI
- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc]init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.frame = [UIScreen mainScreen].bounds;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[YYWIMChatListCell class] forCellReuseIdentifier:cellID];
    self.tableView.tableFooterView = [UIView new];
    [self getConversationList];
    for (RCConversation *conversation in self.conversationList) {
        NSLog(@"会话类型：%lu，目标会话ID：%@", (unsigned long)conversation.conversationType, conversation.targetId);
    }
    // 设置消息接收监听
    [[RCIMClient sharedRCIMClient] setReceiveMessageDelegate:self object:nil];
}

#pragma mark Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.conversationList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YYWIMChatListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    RCConversation *conversation = self.conversationList[indexPath.row];
    int count = [self getUserIDUnreadCount:conversation.conversationType taget:conversation.targetId];
    [cell loadUreadNumber:count];
    NSLog(@"个数 －－－》%d",[self getUserIDUnreadCount:conversation.conversationType taget:conversation.targetId]);
    [cell loadLastMessageTime:[self getRecieceTime:conversation.receivedTime/1000]];
    [cell loadUserName:conversation.targetId];
    NSString *content = [self getLastMessage:conversation.conversationType targetID:conversation.targetId count:count];
    [cell loadLastMessage:content];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RCConversation *conversition = [RCConversation new];
    conversition.conversationType = ConversationType_PRIVATE;
    RCConversation *conversation = self.conversationList[indexPath.row];
    conversition.targetId = conversation.targetId;
    conversition.senderUserId = @"1";
    ChatCollectionViewController *collectionVC = [[ChatCollectionViewController alloc]init];
    collectionVC.targetId =conversation.targetId;
    [self.navigationController pushViewController:collectionVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}

/*!
 接收消息的回调方法
 
 @param message     当前接收到的消息
 @param nLeft       还剩余的未接收的消息数，left>=0
 @param object      消息监听设置的key值
 
 @discussion 如果您设置了IMlib消息监听之后，SDK在接收到消息时候会执行此方法。
 其中，left为还剩余的、还未接收的消息数量。比如刚上线一口气收到多条消息时，通过此方法，您可以获取到每条消息，left会依次递减直到0。
 您可以根据left数量来优化您的App体验和性能，比如收到大量消息时等待left为0再刷新UI。
 object为您在设置消息接收监听时的key值。
 */
- (void)onReceived:(RCMessage *)message
              left:(int)nLeft
            object:(id)object {
//    NSLog(@"------>%@",message);
    if ([message.content isMemberOfClass:[RCTextMessage class]]) {
        
        RCTextMessage *testMessage = (RCTextMessage *)message.content;
        NSLog(@"消息内容：%@", testMessage.content);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self getConversationList];
            [self.tableView reloadData];
        });
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self getConversationList];
        [self.tableView reloadData];
    });
    NSLog(@"还剩余的未接收的消息数：%d", nLeft);
}


#pragma mark Event
#pragma mark Responder
#pragma mark Other
// 获取某一个回话的未读信息的条数
- (int) getUserIDUnreadCount:(RCConversationType)conversationType taget:(NSString *)targetID{
    
    return [[RCIMClient sharedRCIMClient] getUnreadCount:conversationType targetId:targetID];
}
// 时间戳的转换
- (NSString *)getRecieceTime:(long long)secs{
    
    NSString *timeText = nil;
    
    NSDate *messageDate = [NSDate dateWithTimeIntervalSince1970:secs];

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *strMsgDay = [formatter stringFromDate:messageDate];
    
    NSDate *now = [NSDate date];
    NSString *strToday = [formatter stringFromDate:now];
    NSDate *yesterday = [[NSDate alloc] initWithTimeIntervalSinceNow:-(24 * 60 * 60)];
    NSString *strYesterday = [formatter stringFromDate:yesterday];
    
    NSString *_yesterday = nil;
    if ([strMsgDay isEqualToString:strToday]) {
        [formatter setDateFormat:@"HH':'mm"];
    } else if ([strMsgDay isEqualToString:strYesterday]) {
        
        _yesterday = NSLocalizedStringFromTable(@"Yesterday", @"RongCloudKit", nil);
    }
    if (nil != _yesterday) {
        timeText = @"昨天"; //[_yesterday stringByAppendingFormat:@" %@", timeText];
    } else {
        timeText = [formatter stringFromDate:messageDate];
    }
    
    return timeText;
}
// 获取某回话最后一条未读信息
- (RCMessage *)lastMes:(RCConversationType)conversationType targetID:(NSString *)targetID count:(int)count{
    
    NSArray *mesArray = [[RCIMClient sharedRCIMClient] getLatestMessages:conversationType targetId:targetID count:count];
    NSLog(@"获取到的对象 －－－－>%@",[mesArray firstObject]);
    RCMessage *message = [mesArray firstObject];
    return message;
}

- (NSString *)getLastMessage:(RCConversationType)conversationType targetID:(NSString *)targetID count:(int)count{
    
    RCMessage *message = (RCMessage *)[self lastMes:conversationType targetID:targetID count:count];
    NSString *messageType = nil;
    if ([message isKindOfClass:[RCTextMessage class]]) {
        
        RCTextMessage *mes = (RCTextMessage *)message;
        messageType = mes.content;
    }else if([message isKindOfClass:[RCImageMessage class]]){
        
        messageType = @"<图片>";
    }
    else if([message isKindOfClass:[RCVoiceMessage class]]){
        messageType = @"<语音>";
    }
    else if([message isKindOfClass:[RCLocationMessage class]]){
        messageType = @"<位置>";
    }
    return messageType;
}

// 获取
- (void) getConversationList{
    
   NSArray *listArray = [[RCIMClient sharedRCIMClient]
                             getConversationList:@[@(ConversationType_PRIVATE),
                                                   @(ConversationType_DISCUSSION),
                                                   @(ConversationType_GROUP),
                                                   @(ConversationType_SYSTEM),
                                                   @(ConversationType_APPSERVICE),
                                                   @(ConversationType_PUBLICSERVICE)]];
    self.conversationList = [NSMutableArray arrayWithArray:listArray];
    for (NSInteger i = 0; i < self.conversationList.count; i ++) {
        
        RCConversation *conversation = self.conversationList[i];
        if ([conversation.targetId isEqualToString:@"1"]) {
            
            [self.conversationList removeObjectAtIndex:i];
            break;
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
