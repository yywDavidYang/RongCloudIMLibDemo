//
//  YYWIMLoginViewController.m
//  IMLIBDemo
//
//  Created by apple on 16/5/11.
//  Copyright © 2016年 ZDH. All rights reserved.
//

#import "YYWIMLoginViewController.h"
#import "GYContactCardMessage.h"
#import <RongIMLib/RongIMLib.h>
#import "YYWIMChatListViewController.h"

#define kRONGCLOUD_IM_TOKEN @"C1xk1DgT7i6LQQaE2m4ZRgnvWg5OTMf0wiN7jo9iRcRpE5hUXQfne7rwYnOA1CeH8awJp9JRYXQ="
#define ShareApplicationDelegate [[UIApplication sharedApplication] delegate]

@interface YYWIMLoginViewController ()



@end

@implementation YYWIMLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self loginRongCloud];
    [[RCIMClient sharedRCIMClient] registerMessageType:GYContactCardMessage.class];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)loginRongCloud
{
    //登录融云服务器,开始阶段可以先从融云API调试网站获取，之后token需要通过服务器到融云服务器取。
    [[RCIMClient sharedRCIMClient] connectWithToken:kRONGCLOUD_IM_TOKEN
                                            success:^(NSString *userId) {
                                                
                                                NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
                                            // 在主线程刷新界面
                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                
                                                YYWIMChatListViewController *chatListVC = [[YYWIMChatListViewController alloc]init];
                                                [self.navigationController pushViewController:chatListVC animated:YES];
                                            });
                                            } error:^(RCConnectErrorCode status) {
                                                NSLog(@"登陆的错误码为:%ld", (long)status);
                                            } tokenIncorrect:^{
                                                //token过期或者不正确。
                                                //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
                                                //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
                                                NSLog(@"token错误");
                                            }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
