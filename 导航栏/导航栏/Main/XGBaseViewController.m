//
//  XGBaseViewController.m
//  导航栏
//
//  Created by 小果 on 16/9/10.
//  Copyright © 2016年 小果. All rights reserved.
//

#import "XGBaseViewController.h"

@interface XGBaseViewController ()

@end

@implementation XGBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backPreviousVC)];
    self.navigationItem.backBarButtonItem = back;
    
    [self setupUI];
    
}
-(void)setupUI{


}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 30;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"hiddenCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = [UIColor randomColor];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第  %@  行数据",@(indexPath.row).description];
    
    return cell;
}

-(void)backPreviousVC{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
