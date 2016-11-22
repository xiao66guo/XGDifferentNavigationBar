//
//  XGRandColorCell.m
//  导航栏
//
//  Created by 小果 on 16/9/11.
//  Copyright © 2016年 小果. All rights reserved.
//

#import "XGRandColorCell.h"

@implementation XGRandColorCell
+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"cell";
    XGRandColorCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (nil == cell) {
        cell = [[XGRandColorCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifie{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifie]) {
        [self cellTextLabelWithColor];
        [self addTimer];
    }
    return self;
}
-(void)cellTextLabelWithColor{
    self.textLabel.textColor = [UIColor randomColor];
    self.textLabel.font = [UIFont boldSystemFontOfSize:20];
    self.textLabel.layer.shadowColor = [UIColor randomColor].CGColor;
    self.textLabel.layer.shadowOffset = CGSizeMake(0, -5);
    self.textLabel.layer.shadowRadius = 0;
    self.textLabel.layer.shadowOpacity = 0.5;
}

#pragma mark - 添加定时器
-(void)addTimer{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(cellTextLabelWithColor) userInfo:nil repeats:YES];
    // 如果用户在主线程做其他操作的话，定时器不会执行，将其加到这里可以让用户在执行其他操作时，分出一些时间给定时器
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}
@end
