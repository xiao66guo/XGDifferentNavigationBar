//
//  XGScrollModel.m
//  导航栏
//
//  Created by 小果 on 16/9/11.
//  Copyright © 2016年 小果. All rights reserved.
//

#import "XGScrollModel.h"

@implementation XGScrollModel

-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]){
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+(instancetype)modelWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

+(NSArray *)arryWithContents{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"models.plist" ofType:nil];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    
    NSMutableArray *mutable = [NSMutableArray array];
    
    [array enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
        XGScrollModel *mod = [XGScrollModel modelWithDict:dict];
        [mutable addObject:mod];
    }];
    return mutable.copy;
}
@end
