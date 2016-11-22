//
//  XGNavHiddenController.m
//  导航栏
//
//  Created by 小果 on 16/9/10.
//  Copyright © 2016年 小果. All rights reserved.
//

#import "XGNavHiddenController.h"

@interface XGNavHiddenController ()

@end

@implementation XGNavHiddenController

-(void)setupUI{
    
    UITableView *tab = [[UITableView alloc] initWithFrame:self.view.bounds];
    tab.dataSource = self;
    tab.delegate = self;
    self.table = tab;
    [self.view addSubview:tab];
}
// 隐藏的方法设置
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;

    if (offsetY > 100) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }else{
        [self.navigationController setNavigationBarHidden:NO animated:NO];
    }

}

@end
