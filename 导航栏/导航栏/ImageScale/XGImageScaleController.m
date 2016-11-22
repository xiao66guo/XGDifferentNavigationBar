//
//  XGImageScaleController.m
//  导航栏
//
//  Created by 小果 on 16/9/11.
//  Copyright © 2016年 小果. All rights reserved.
//

#import "XGImageScaleController.h"
@interface XGImageScaleController ()
@property (nonatomic, weak) UIView *headerView;
@property (nonatomic, weak) UIImageView *headImageView;
@end
@implementation XGImageScaleController
-(void)setupUI{
    UITableView *table = [[UITableView alloc] initWithFrame:self.view.bounds];
    table.dataSource = self;
    table.delegate = self;
    [self.view addSubview:table];
    self.table = table;
    
    [self settingHeaderView];
    
    [self settingHeaderBackgroundView];
}

#pragma mark - 设置头部
-(void)settingHeaderView{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, XGHeaderImageH-15)];
    self.table.tableHeaderView = headerView;
    self.headerView = headerView;
}

#pragma mark - 设置backgroundView
-(void)settingHeaderBackgroundView{
    UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, XGHeaderImageH)];
    headImageView.contentMode = UIViewContentModeScaleAspectFill;
    headImageView.image = [UIImage imageNamed:@"head.jpg"];
    self.headImageView = headImageView;
    
    UIView *backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    [backGroundView addSubview:headImageView];
    
    self.table.backgroundView = backGroundView;
}

#pragma mark - 设置滚动放大和缩小
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // 向下滚动offsetY值变为负值，越来越小，向上滚动offsetY值是正值，越来越大
    CGFloat offsetY = scrollView.contentOffset.y;
    
    CGRect tempF = self.headImageView.frame;
    // 如果offsetY大于0，说明是向上滚动，缩小
    if (offsetY > 0) {
        tempF.origin.y = -offsetY;
        self.headImageView.frame = tempF;

    }else{
        // 如果offsetY小于0，让headImageView的Y值等于0，headImageView的高度要放大
        tempF.size.height = XGHeaderImageH - offsetY;
        tempF.origin.y = 0;
        self.headImageView.frame = tempF;
    }
    
}

#pragma mark - Cell出现时或者刷新的动画
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //缩放
    cell.layer.transform = CATransform3DMakeScale(1, 0.6, 1);
    [UIView animateWithDuration:1 animations:^{
        cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
    }];
    
}
@end
