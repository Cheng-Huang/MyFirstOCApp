//
//  HCShop.m
//  MyFirstOCApp
//
//  Created by 成 黄 on 16/4/27.
//  Copyright © 2016年 成 黄. All rights reserved.
//

#import "HCShop.h"

@implementation HCShop
- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        self.name = dict[@"name"];
        self.icon = dict[@"icon"];
    }
    return self;
}

+ (instancetype)shopWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

@end
