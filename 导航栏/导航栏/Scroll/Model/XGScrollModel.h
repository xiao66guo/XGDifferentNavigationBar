//
//  XGScrollModel.h
//  导航栏
//
//  Created by 小果 on 16/9/11.
//  Copyright © 2016年 小果. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XGScrollModel : NSObject
@property (nonatomic, copy) NSString *icon;

@property (nonatomic, copy) NSString *name;

-(instancetype)initWithDict:(NSDictionary *)dict;

+(instancetype)modelWithDict:(NSDictionary *)dict;

+(NSArray *)arryWithContents;
@end
