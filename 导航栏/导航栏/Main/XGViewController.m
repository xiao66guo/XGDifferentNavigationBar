//
//  XGViewController.m
//  导航栏
//
//  Created by 小果 on 16/9/10.
//  Copyright © 2016年 小果. All rights reserved.
//

#import "XGViewController.h"
#import "XGNavHiddenController.h"
#import "XGAlphaViewController.h"
#import "XGImageScaleController.h"
#import "XGCellCopyController.h"
#import "XGRandColorCell.h"
#import "XGScrollController.h"

@interface XGViewController ()
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, weak) UITableViewCell *RandCell;
@end

@implementation XGViewController
-(NSArray *)dataSource{
    if (nil == _dataSource) {
        _dataSource = [NSArray array];
    }
    return _dataSource;
}

-(void)setupUI{
    
    self.dataSource = @[@{@"name":@"导航栏隐藏与显示"},@{@"name":@"导航栏透明渐变"},@{@"name":@"图片下拉放大"},@{@"name":@"Cell的复制粘贴"},@{@"name":@"无限滚动(手动和定时)"}];
    
    UITableView *tab = [[UITableView alloc] initWithFrame:self.view.bounds];
    tab.dataSource = self;
    tab.delegate = self;
    self.table = tab;
    [self.view addSubview:tab];
    self.navigationItem.leftBarButtonItem = nil;
    [self.navigationController.navigationBar setShadowImage:nil];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XGRandColorCell *cell = [XGRandColorCell cellWithTableView:tableView];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *dict = self.dataSource[indexPath.row];
    cell.textLabel.text = dict[@"name"];

    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:
        {
            XGNavHiddenController *hid = [[XGNavHiddenController alloc] init];
            hid.title = self.dataSource[indexPath.row][@"name"];
            [self.navigationController pushViewController:hid animated:YES];
        }
        break;
        case 1:
        {
            XGAlphaViewController *alpha = [[XGAlphaViewController alloc] init];
            alpha.titleName = self.dataSource[indexPath.row][@"name"];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:alpha];
            [self presentViewController:nav animated:YES completion:nil];

        }
        break;
        case 2:
        {
            XGImageScaleController *imageScale = [[XGImageScaleController alloc] init];
            imageScale.title = self.dataSource[indexPath.row][@"name"];
            [self.navigationController pushViewController:imageScale animated:YES];
        }
        break;
        case 3:
        {
            XGCellCopyController *cellCopy = [[XGCellCopyController alloc] init];
            cellCopy.title = self.dataSource[indexPath.row][@"name"];
            [self.navigationController pushViewController:cellCopy animated:YES];
        }
        break;
        case 4:
        {
            XGScrollController *scroll = [[XGScrollController alloc] init];
            scroll.title = self.dataSource[indexPath.row][@"name"];
            [self.navigationController pushViewController:scroll animated:YES];
        }
        default:
            break;
    }
    
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    XGRandColorCell *cell = [[XGRandColorCell alloc] init];
    [cell removeTimer];
}
@end
