//
//  UINavigationBar+XGAlphaBar.h
//  导航栏
//
//  Created by 小果 on 16/9/10.
//  Copyright © 2016年 小果. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (XGAlphaBar)

// 分类的作用  可以添加方法 添加属性
@property (nonatomic , strong)UIView *AlphaView;

// 提供一个渐变透明的方法
- (void)changeNavAlphaWithColor:(UIColor *)color;


@end
