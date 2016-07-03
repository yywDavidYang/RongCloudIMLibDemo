//
//  AudioPlayHelper.m
//  KeyBoardView
//
//  Created  on 16/3/28.
//  Copyright  All rights reserved.
//

#import "AudioPlayHelper.h"
#import <AVFoundation/AVFoundation.h>


@interface AudioPlayHelper ()<AVAudioPlayerDelegate>

@property(nonatomic,strong) AVAudioPlayer *player;

//@property(nonatomic,strong) NSURL *lastUrl;

@end
@implementation AudioPlayHelper

+ (instancetype)helper
{
    static dispatch_once_t onceToken;
    static AudioPlayHelper * helper = nil;
    dispatch_once(&onceToken, ^{
        
        helper = [[self alloc]init];
    });
    return helper;
}


- (void)playAudioWithFileUrl:(NSURL *)url finishPlay:(void(^)(NSString *))didFinishPlaying
{
    self.audioPlayerDidFinishPlaying = didFinishPlaying;
    self.player = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    self.player.delegate = self;
    [self.player prepareToPlay];
    [self.player play];
}

- (void) playAudioWithData:(NSData *)data finishPlay:(void (^)(NSString *))didFinishPlaying{
 
    self.audioPlayerDidFinishPlaying = didFinishPlaying;
    self.player = [[AVAudioPlayer alloc]initWithData:data error:nil];
    self.player.delegate = self;
    [self.player prepareToPlay];
    [self.player play];
}

- (void)pauseAudioWithFileUrl:(NSURL *)url
{
    [self.player stop];
}


- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    self.audioPlayerDidFinishPlaying ? self.audioPlayerDidFinishPlaying(self.player.url.path) : nil;
}







@end
