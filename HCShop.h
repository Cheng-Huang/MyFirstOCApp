//
//  HCShop.h
//  MyFirstOCApp
//
//  Created by 成 黄 on 16/4/27.
//  Copyright © 2016年 成 黄. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCShop : NSObject
/**
 *  商品名称
 */
@property (nonatomic, strong) NSString *name;
/**
 *  图标
 */
@property (nonatomic, strong) NSString *icon;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)shopWithDict:(NSDictionary *)dict;
@end
