//
//  HCShopView.h
//  MyFirstOCApp
//
//  Created by 成 黄 on 16/4/28.
//  Copyright © 2016年 成 黄. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HCShop;

@interface HCShopView : UIView
/**
 *  商品模型
 */
@property (strong, nonatomic) HCShop *shop;

+ (instancetype)shopView;
@end
