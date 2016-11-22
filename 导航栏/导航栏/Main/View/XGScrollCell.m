//
//  XGScrollCell.m
//  导航栏
//
//  Created by 小果 on 16/9/11.
//  Copyright © 2016年 小果. All rights reserved.
//

#import "XGScrollCell.h"
#import "XGScrollModel.h"
@interface XGScrollCell ()
@property (nonatomic, weak) UIImageView *iconView;
@property (nonatomic, weak) UILabel *nameLab;
@end

@implementation XGScrollCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        
        [self createSubViews];
        
    }
    return self;
}
#pragma mark - 设置Cell中的控件
-(void)createSubViews{
    
    UIImageView *iconView = [[UIImageView alloc] init];
    iconView.contentMode = UIViewContentModeScaleAspectFit;
    self.iconView = iconView;
    [self.contentView addSubview:iconView];
    
    UILabel *nameLab = [[UILabel alloc] init];
    nameLab.textAlignment = NSTextAlignmentCenter;
    nameLab.textColor = [UIColor blueColor];
    self.nameLab = nameLab;
    nameLab.font = [UIFont boldSystemFontOfSize:30];
    [self.iconView addSubview:nameLab];
}
#pragma mark - 设置控件的frame
-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.iconView.frame = CGRectMake(0, 0, self.width, self.height);
    
    self.nameLab.frame = CGRectMake(0, 200, self.width, 40);

    
}
#pragma mark - 设置数据
-(void)setModel:(XGScrollModel *)model{
    _model = model;
    
    self.iconView.image = [UIImage imageNamed:model.icon];
    
    self.nameLab.text = NSString(@" %@",model.name);
}

@end
