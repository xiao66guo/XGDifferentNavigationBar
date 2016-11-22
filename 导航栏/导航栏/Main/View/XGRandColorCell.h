//
//  XGRandColorCell.h
//  导航栏
//
//  Created by 小果 on 16/9/11.
//  Copyright © 2016年 小果. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XGRandColorCell : UITableViewCell
@property (nonatomic, strong) NSTimer *timer;
-(void)removeTimer;
+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
