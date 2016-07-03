//
//  YYWIMChatListCell.m
//  IMLIBDemo
//
//  Created by apple on 16/5/11.
//  Copyright © 2016年 ZDH. All rights reserved.
//

#import "YYWIMChatListCell.h"
#import "Masonry.h"

@interface YYWIMChatListCell()
/**
 *  回话列表的头像
 */
@property (nonatomic,strong) UIImageView *headerImageView;
/**
 *  回话列表的未读消息参数
 */
@property (nonatomic,strong) UILabel *countLabel;
/**
 *  回话好友名称
 */
@property (nonatomic,strong) UILabel *nameLabel;
/**
 *  最后一条信息
 */
@property (nonatomic,strong) UILabel *lastMesLabel;
/**
 *  最后一条消息的时间
 */
@property (nonatomic,strong) UILabel *mesTimeLabel;
@property (nonatomic,strong) UIView *seperateLine;


@end
@implementation YYWIMChatListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self createUI];
        [self autolayout];
    }
    return self;
}

#pragma mark CreateUI
- (void) createUI{
   
    self.headerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 40, 40)];
    self.headerImageView.backgroundColor = [UIColor blueColor];
    self.headerImageView.image = [UIImage imageNamed:@"ICON"];
    [self.contentView addSubview:self.headerImageView];
    
    self.nameLabel = [[UILabel alloc]init];
    self.nameLabel.textColor = [UIColor blackColor];
    self.nameLabel.text = @"YYW";
    [self.contentView addSubview:self.nameLabel];
    
    self.lastMesLabel = [[UILabel alloc]init];
    self.lastMesLabel.textColor = [UIColor grayColor];
    self.lastMesLabel.text = @"haha~~~";
    [self.contentView addSubview:self.lastMesLabel];
    
    self.mesTimeLabel = [[UILabel alloc]init];
    self.mesTimeLabel.textColor = [UIColor grayColor];
    self.mesTimeLabel.text = @"15:02";
    [self.contentView addSubview:self.mesTimeLabel];
    
    self.countLabel = [[UILabel alloc]init];
    self.countLabel.backgroundColor = [UIColor redColor];
    self.countLabel.text = @"155";
    self.countLabel.textAlignment  = NSTextAlignmentCenter;
    self.countLabel.font = [UIFont systemFontOfSize:12 weight:12];
    self.countLabel.textColor =  [UIColor whiteColor];
    self.countLabel.layer.cornerRadius = 7.50;
    self.countLabel.layer.masksToBounds = YES;
    [self.contentView addSubview:self.countLabel];
    
    self.seperateLine= [[UIView alloc]init];
    self.seperateLine.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:self.seperateLine];
}

- (void) autolayout{
    
//    [_headerImageView mas_makeConstraints:^(MASConstraintMaker *make){
//        
//        make.left.equalTo(self.contentView.mas_left).offset(10);
//        make.top.equalTo(self.contentView.mas_top).offset(3);
//        make.bottom.equalTo(self.contentView.mas_bottom).offset(3);
//        make.width.equalTo(@40);
//    }];

    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make){
    
        make.left.equalTo(_headerImageView.mas_right).offset(5);
        make.top.equalTo(_headerImageView.mas_top);
        make.bottom.equalTo(self.contentView.mas_centerY);
    }];
    
    [_lastMesLabel mas_makeConstraints:^(MASConstraintMaker *make){
    
        make.top.equalTo(self.contentView.mas_centerY).offset(0);
        make.bottom.equalTo(_headerImageView.mas_bottom);
        make.left.equalTo(_headerImageView.mas_right).offset(5);
    }];
    
    [_mesTimeLabel mas_makeConstraints:^(MASConstraintMaker *make){
    
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(_headerImageView.mas_top);
        make.bottom.equalTo(self.contentView.mas_centerY);
    }];
    
    [_countLabel mas_makeConstraints:^(MASConstraintMaker *make){
    
        make.center.equalTo(_headerImageView.mas_top).offset(0);
        make.center.equalTo(_headerImageView.mas_right).offset(0);
        make.height.mas_equalTo(15);
    }];
    
    [_seperateLine mas_makeConstraints:^(MASConstraintMaker *make){
    
        make.height.mas_equalTo(1);
        make.bottom.left.right.equalTo(self.contentView);
    }];
    
}
#pragma mark Delegate
#pragma mark Event
#pragma mark Responder
#pragma mark Other
// 未读的消息
- (void) loadUreadNumber:(int) count{
    
    if (count > 0) {
        
        NSString *count1 = [NSString stringWithFormat:@"%d",count];
        self.countLabel.text = count1;
    }
}
// 名称
- (void) loadUserName:(NSString *)name{
    
    self.nameLabel.text = name;
}
// 加载最后一条信息
- (void) loadLastMessage:(NSString *)mes{
    
    self.lastMesLabel.text = mes;
}

// 加载消息的时间
- (void) loadLastMessageTime:(NSString *)time{
    self.mesTimeLabel.text = time;
}

- (void) loadChatListHeadImageUrl:(NSString *)headerViewUrl{
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
