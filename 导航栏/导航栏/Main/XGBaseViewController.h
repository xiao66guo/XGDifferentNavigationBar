//
//  XGBaseViewController.h
//  导航栏
//
//  Created by 小果 on 16/9/10.
//  Copyright © 2016年 小果. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XGBaseViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) UITableView *table;


-(void)setupUI;
@end
