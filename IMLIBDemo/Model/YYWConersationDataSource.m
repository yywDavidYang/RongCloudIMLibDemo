//
//  YYWConersationModel.m
//  IMLIBDemo
//
//  Created by apple on 16/5/12.
//  Copyright © 2016年 ZDH. All rights reserved.
//

#import "YYWConersationDataSource.h"
#import "NSDate+Addition.h"
#import <RongIMLib/RongIMLib.h>

#define kRCAppKey @"c9kqb3rdkglrj"

@interface YYWConersationDataSource()


@end

@implementation YYWConersationDataSource
// 文本消息
+ (MessageModel *)getTextMessage:(RCMessage *)message{
    // messageDirection
    RCTextMessage *textMessage1 =  (RCTextMessage *)message.content;
    BOOL isSender = NO;
    if (message.messageDirection == MessageDirection_SEND) {
        
        isSender = YES;
    }
    else if (message.messageDirection == MessageDirection_RECEIVE){
        
        isSender = NO;
    }
    
    MessageModel *textMessage = [TextMessageModel text:textMessage1.content username:@"qyu" timeStamp:[NSDate date:[NSDate date] WithFormate:KDateFormate] isSender:isSender];
    textMessage.avatar = [UIImage imageNamed:@"avatar"];
    
    if (isSender) {
        
        textMessage.avatarUrl = @"http://d.hiphotos.baidu.com/zhidao/wh%3D450%2C600/sign=603e37439313b07ebde8580c39e7bd15/a8014c086e061d9591b7875a7bf40ad163d9cadb.jpg";
        MessageServiceModel *imMessage = [[MessageServiceModel alloc]init];
        imMessage.from = message.content.senderUserInfo.name;
        imMessage.to = @"lucy";
        imMessage.messageId = [NSString stringWithFormat:@"%@",message.messageUId];
        textMessage.imMessage = imMessage;
        
    }else{
        
        textMessage.avatarUrl = @"http://www.deskcar.com/desktop/game/netgame/200882963407/2.jpg";
        textMessage.deliveryState = MessageDeliveryStateDelivered;
        MessageServiceModel *imMessage = [[MessageServiceModel alloc]init];
        imMessage.from = message.content.senderUserInfo.name;;
        imMessage.to = @"joy";
        imMessage.messageId = [NSString stringWithFormat:@"%@",message.messageUId];
        textMessage.imMessage = imMessage;
    }
    textMessage.bubbleMessageBodyType = MessageBodyTypeText;
    return textMessage;
}

// 图片的发送与接收
+ (MessageModel *)getPhotoMessage:(RCMessage *)message
{
    // messageDirection
    RCImageMessage *imageMessage1 =  (RCImageMessage *)message.content;
    BOOL isSender = NO;
    if (message.messageDirection == MessageDirection_SEND) {
        
        isSender = YES;
    }
    else if (message.messageDirection == MessageDirection_RECEIVE){
        
        isSender = NO;
    }
    NSLog(@"------>图片Url = %@",imageMessage1.imageUrl);
    MessageModel *photoMessage = [PhotoMessageModel Photo:nil thumbnailUrl:imageMessage1.imageUrl originPhotoUrl:@"" username:@"joy" timeStamp:[NSDate date:[NSDate date] WithFormate:KDateFormate] isSender:isSender];
    photoMessage.avatar = [UIImage imageNamed:@"avatar"];
    
    if (isSender) {
        photoMessage.avatarUrl = @"http://d.hiphotos.baidu.com/zhidao/wh%3D450%2C600/sign=603e37439313b07ebde8580c39e7bd15/a8014c086e061d9591b7875a7bf40ad163d9cadb.jpg";
        photoMessage.localPhotoPath = imageMessage1.imageUrl;
//        photoMessage.isGif = isGif;
//        photoMessage.deliveryState = 1+ arc4random_uniform(2);
        MessageServiceModel *imMessage = [[MessageServiceModel alloc]init];
        imMessage.from = @"joy";
        imMessage.to = @"lucy";
        photoMessage.imMessage = imMessage;
    }else{
        //模仿服务器返回图片尺寸size
        photoMessage.avatarUrl = @"http://www.deskcar.com/desktop/game/netgame/200882963407/2.jpg";
        if ([imageMessage1.extra isEqualToString:@"gif"]) {
            
            photoMessage.isGif = YES;
        }else{
            
            photoMessage.isGif = NO;
        }
        photoMessage.thumbnailUrl = imageMessage1.imageUrl;
        photoMessage.size = imageMessage1.thumbnailImage.size;
        photoMessage.deliveryState = MessageDeliveryStateDelivered;
        MessageServiceModel *imMessage = [[MessageServiceModel alloc]init];
        imMessage.from = @"lucy";
        imMessage.to = @"joy";
        photoMessage.imMessage = imMessage;
    }
    photoMessage.bubbleMessageBodyType = MessageBodyTypePhoto;
    return photoMessage;
}
// 音频的发送与接收
+ (MessageModel *)getVoiceMessage:(RCMessage *)message withVoicePath:(NSString *)voicePath
{
//    获取语音的缓存地址
//    NSString *document = NSHomeDirectory();
//    documents/appkey/userid/storage
//    NSString *currentUserID = [RCIMClient sharedRCIMClient].currentUserInfo.userId;
//    NSString *documentPath = [NSString stringWithFormat:@"%@/%@/%@/storage",document,kRCAppKey,currentUserID];
    RCVoiceMessage *voiceMessage1 =  (RCVoiceMessage *)message.content;
    BOOL isSender = NO;
    if (message.messageDirection == MessageDirection_SEND) {
        
        isSender = YES;
    }
    else if (message.messageDirection == MessageDirection_RECEIVE){
        
        isSender = NO;
    }
    
    VoiceMessageModel *voiceMessage = [VoiceMessageModel VoicePath:nil voiceUrl:nil voiceDuration:nil username:nil timeStamp:[NSDate date:[NSDate date] WithFormate:KDateFormate] isSender:isSender];
    
    if (isSender) {
        
        voiceMessage.avatarUrl = @"http://d.hiphotos.baidu.com/zhidao/wh%3D450%2C600/sign=603e37439313b07ebde8580c39e7bd15/a8014c086e061d9591b7875a7bf40ad163d9cadb.jpg";
        voiceMessage.deliveryState = 1+ arc4random_uniform(2);
        MessageServiceModel *imMessage = [[MessageServiceModel alloc]init];
        imMessage.from = @"joy";
        imMessage.to = @"lucy";
        voiceMessage.imMessage = imMessage;
        voiceMessage.voicePath = voicePath;
        
    }else{
        
        voiceMessage.avatarUrl = @"http://www.deskcar.com/desktop/game/netgame/200882963407/2.jpg";
        voiceMessage.deliveryState = MessageDeliveryStateDelivered;
        MessageServiceModel *imMessage = [[MessageServiceModel alloc]init];
        imMessage.from = @"lucy";
        imMessage.to = @"joy";
        voiceMessage.imMessage = imMessage;
        voiceMessage.voiceData =voiceMessage1.wavAudioData;
    }
    voiceMessage.bubbleMessageBodyType = MessageBodyTypeVoice;
    voiceMessage.voiceDuration = [NSString stringWithFormat:@"%ld",voiceMessage1.duration];
    voiceMessage.isRead = arc4random_uniform(2);
    return voiceMessage;
}

+ (MessageModel *)getlocationsMessage:(RCMessage *)message
{
    RCLocationMessage *locationMessage1 =  (RCLocationMessage *)message.content;
    BOOL isSender = NO;
    if (message.messageDirection == MessageDirection_SEND) {
        
        isSender = YES;
    }
    else if (message.messageDirection == MessageDirection_RECEIVE){
        
        isSender = NO;
    }
    
    MessageModel *localPositionMessage = [LocationMessageModel LocationPositionImage:locationMessage1.thumbnailImage loaction:locationMessage1.location locationName:locationMessage1.locationName userName:@"" timeStamp:@"" isSender:isSender];
    
    if (isSender) {
        
        localPositionMessage.avatarUrl = @"http://d.hiphotos.baidu.com/zhidao/wh%3D450%2C600/sign=603e37439313b07ebde8580c39e7bd15/a8014c086e061d9591b7875a7bf40ad163d9cadb.jpg";
        localPositionMessage.deliveryState = 1+ arc4random_uniform(2);
        MessageServiceModel *imMessage = [[MessageServiceModel alloc]init];
        imMessage.from = @"joy";
        imMessage.to = @"lucy";
        localPositionMessage.imMessage = imMessage;
    }else{
        
        localPositionMessage.avatarUrl = @"http://www.deskcar.com/desktop/game/netgame/200882963407/2.jpg";
        localPositionMessage.deliveryState = MessageDeliveryStateDelivered;
        MessageServiceModel *imMessage = [[MessageServiceModel alloc]init];
        imMessage.from = @"lucy";
        imMessage.to = @"joy";
        localPositionMessage.location2 = locationMessage1.location;
        localPositionMessage.thumbnailImage = locationMessage1.thumbnailImage;
        localPositionMessage.address = locationMessage1.locationName;
        localPositionMessage.imMessage = imMessage;
    }
    localPositionMessage.bubbleMessageBodyType = MessageBodyTypeLocation;
    return localPositionMessage;
}

//// video的发送与接收
//+ (MessageModel *)getVideoMessage:(BOOL)isSender
//{
//    
//    MessageModel *videoMessage = [VideoMessageModel VideoThumbPhoto:nil videoThumbUrl:nil videoUrl:nil username:nil timeStamp:[NSDate date:[NSDate date] WithFormate:KDateFormate] isSender:isSender];
//    
//    
//    if (isSender) {
//        videoMessage.avatarUrl = @"http://d.hiphotos.baidu.com/zhidao/wh%3D450%2C600/sign=603e37439313b07ebde8580c39e7bd15/a8014c086e061d9591b7875a7bf40ad163d9cadb.jpg";
//        videoMessage.videoThumbPhoto = @[[[NSBundle mainBundle]pathForResource:@"playVideo1.jpg" ofType:nil],[[NSBundle mainBundle]pathForResource:@"playVideo2.jpg" ofType:nil]][arc4random_uniform(2)];
//        videoMessage.locationVideoPath = [[NSBundle mainBundle]pathForResource:@"150511_JiveBike.mov" ofType:nil];
//        videoMessage.isVideoCache = YES;
//        videoMessage.deliveryState = 1+ arc4random_uniform(2);
//        
//        MessageServiceModel *imMessage = [[MessageServiceModel alloc]init];
//        imMessage.from = @"joy";
//        imMessage.to = @"lucy";
//        //        imMessage.messageId = [self getMessageId];
//        videoMessage.imMessage = imMessage;
//        
//    }else{
//        videoMessage.avatarUrl = @"http://d.hiphotos.baidu.com/zhidao/wh%3D450%2C600/sign=603e37439313b07ebde8580c39e7bd15/a8014c086e061d9591b7875a7bf40ad163d9cadb.jpg";
//        videoMessage.deliveryState = MessageDeliveryStateDelivered;
//    http://www.mydigi.net/article/UploadPic/2013-5/2013514213339424.png
//        videoMessage.videoThumbUrl = @[
//                                       
//                                       @"http://imgsrc.baidu.com/baike/pic/item/63d0f703918fa0ec9c44c871249759ee3c6ddbcf.jpg"
//                                       ][arc4random_uniform(1)];
//        videoMessage.videoUrl = @"http://baobab.wdjcdn.com/14562919706254.mp4";
//        
//        MessageServiceModel *imMessage = [[MessageServiceModel alloc]init];
//        imMessage.from = @"lucy";
//        imMessage.to = @"joy";
//        //        imMessage.messageId = [self getMessageId];
//        videoMessage.imMessage = imMessage;
//    }
//    videoMessage.bubbleMessageBodyType = MessageBodyTypeVideo;
//    return videoMessage;
//}

// 获取消息数据
+ (NSMutableArray *)getMessageArrayWithRCMessageArray:(NSArray *)messageArray voicePath:(NSString *)voicePath{
    
    NSMutableArray *messagesArray = [NSMutableArray array];
    for (RCMessage *message in messageArray) {
        if ([message.content isKindOfClass:[RCTextMessage class]]) {
           [messagesArray addObject:[self getTextMessage:message]];
        }
        if ([message.content isKindOfClass:[RCImageMessage class]]) {
            NSLog(@"获取图片 %@",message.content);
            [messagesArray addObject:[self getPhotoMessage:message]];
        }
        if ([message.content isKindOfClass:[RCVoiceMessage class]]){
            
            [messagesArray addObject:[self getVoiceMessage:message withVoicePath:voicePath]];
        }
        if ([message.content isKindOfClass:[RCLocationMessage class]]) {
            
            [messagesArray addObject:[self getlocationsMessage:message]];
        }
    }
    return messagesArray;
}

@end
