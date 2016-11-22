//
//  XGCellCopyController.m
//  导航栏
//
//  Created by 小果 on 16/9/11.
//  Copyright © 2016年 小果. All rights reserved.
//

#import "XGCellCopyController.h"
#import "XGRandColorCell.h"
@interface XGCellCopyController ()
@property (nonatomic, weak) XGRandColorCell *cell;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end
@implementation XGCellCopyController

-(NSMutableArray *)dataSource{
    if (nil == _dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

-(void)setupUI{
    
    NSArray *array = @[@{@"name":@"导航栏隐藏与显示"},@{@"name":@"导航栏透明渐变"},@{@"name":@"图片下拉放大"},@{@"name":@"Cell的复制粘贴"},@{@"name":@"无限滚动(手动和定时)"}];
    self.dataSource = [NSMutableArray arrayWithArray:array];
    
    UITableView *table = [[UITableView alloc] initWithFrame:self.view.bounds];
    table.dataSource = self;
    table.delegate = self;
    table.allowsSelection = NO;
    [self.view addSubview:table];
    self.table = table;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XGRandColorCell *cell = [XGRandColorCell cellWithTableView:tableView];
    NSDictionary *dict = self.dataSource[indexPath.row];
    cell.textLabel.text = dict[@"name"];
    
    return cell;
}

#pragma mark - 要不要显示复制、粘贴菜单
-(BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.row == 0) { // 如果是第一行长按时不会显示复制、粘贴菜单
//        return NO;
//    }else{ // 不是第一行就显示
//        return YES;
//    }
    return YES;
}

#pragma mark - 决定菜单上显示的名称
-(BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender{
    if (action == @selector(copy:) || action == @selector(paste:) || action == @selector(cut:)) {
        return YES;
    }else{ // 如果返回yes，会显示全部的菜单
        return NO;
    }
}

#pragma mark - 当点击菜单中的选项时调用的方法
-(void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender{

    if (action == @selector(copy:)){
        
        // 将选中的Cell保存到剪贴板中，剪贴板是全局的
        [UIPasteboard generalPasteboard].strings = @[self.dataSource[indexPath.row][@"name"]];
    }else if (action == @selector(paste:)){
        // 从剪贴板中保存的内容
        NSArray *copyArray = [UIPasteboard generalPasteboard].strings;
        NSDictionary *dict = [NSDictionary dictionaryWithObject:copyArray[0] forKey:@"name"];
        
        [self.dataSource insertObject:dict atIndex:indexPath.row];
        
        [self.table insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }else if (action == @selector(cut:)){
        [UIPasteboard generalPasteboard].strings = @[self.dataSource[indexPath.row][@"name"]];
        [self.dataSource removeObjectAtIndex:indexPath.row];
        
        [self.table deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }

}

#pragma mark - Cell出现时或者刷新的动画
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //缩放
    cell.layer.transform = CATransform3DMakeScale(0.6, 1, 1);
    [UIView animateWithDuration:1 animations:^{
        cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
    }];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    XGRandColorCell *cell = [[XGRandColorCell alloc] init];
    [self.cell removeTimer];
}
@end
