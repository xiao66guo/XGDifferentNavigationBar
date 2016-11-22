//
//  XGAlphaViewController.m
//  导航栏
//
//  Created by 小果 on 16/9/10.
//  Copyright © 2016年 小果. All rights reserved.
//

#import "XGAlphaViewController.h"
@interface XGAlphaViewController ()
@property (nonatomic, weak) UILabel *lab;
@property (nonatomic, weak) UIButton *back;
@end

@implementation XGAlphaViewController
-(void)setupUI{
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, -64, ScreenW, self.view.height+64)];
    table.dataSource = self;
    table.delegate = self;
    [self.view addSubview:table];
    self.table = table;
    
    [self setupCurrentTitleAndBackBtnWithOther];

    // 去除当前控制器导航栏底部的黑线
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}

#pragma mark - 设置头部图片、返回按钮、标题
-(void)setupCurrentTitleAndBackBtnWithOther{
    // 头部图片
    UIImageView *bg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 250)];
    bg.image = [UIImage imageNamed:@"bg.jpg"];
    bg.contentMode = UIViewContentModeScaleToFill;
    self.table.tableHeaderView = bg;
    
    // 返回按钮
    UIButton *back = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [back setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];;
    [back setTitle:@"返回" forState:UIControlStateNormal];
    [back addTarget:self action:@selector(backPreviousVC) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:back];
    self.navigationItem.leftBarButtonItem = backItem;
    self.back = back;
    
    // 标题
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 44)];
    lab.text = self.titleName;
    lab.font = [UIFont boldSystemFontOfSize:18];
    lab.textColor = [UIColor whiteColor];
    lab.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = lab;
    self.lab = lab;
}

#pragma mark - 透明的设置方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    UIColor *color = [UIColor blueColor];
    if (offsetY > 64) {
        if (offsetY > 128) {
            offsetY = 128;
        }
        CGFloat alpha = (offsetY - 64)/64;
        [self.navigationController.navigationBar changeNavAlphaWithColor:[color colorWithAlphaComponent:alpha]];
        self.back.titleLabel.alpha = alpha;
        self.navigationItem.titleView.alpha = alpha;
    }else{
        [self.navigationController.navigationBar changeNavAlphaWithColor:[color colorWithAlphaComponent:0.0]];
        self.back.titleLabel.alpha = 0.0;
        self.navigationItem.titleView.alpha = 0.0;
    }
    
}

-(void)backPreviousVC{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
