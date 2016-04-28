//
//  HCShopView.m
//  MyFirstOCApp
//
//  Created by 成 黄 on 16/4/28.
//  Copyright © 2016年 成 黄. All rights reserved.
//

#import "HCShopView.h"
#import "HCShop.h"

@interface HCShopView()
/**
 *  图片控件
 */
@property (strong, nonatomic) UIImageView *iconView;
/**
 *  名字控件
 */
@property (strong, nonatomic) UILabel *nameLabel;
@end

@implementation HCShopView

+ (instancetype)shopView
{
    return [[self alloc] init];
}


// 重写get方法
- (UIImageView *)iconView
{
    if (_iconView == nil) {
        UIImageView *iconView = [[UIImageView alloc] init];
        iconView.backgroundColor = [UIColor blueColor];
        [self addSubview:iconView];
        self.iconView = iconView;
    }
    return _iconView;
}

- (UILabel *)nameLabel
{
    if (_nameLabel == nil) {
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = [UIFont systemFontOfSize:11];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.backgroundColor = [UIColor redColor];
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
    }
    return _nameLabel;
}

/**
 * 这个方法专门用来布局子控件，一般在这里设置子控件的frame
 * 当控件本身的尺寸发生改变的时候，系统会自动调用这个方法
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat shopW = self.frame.size.width;
    CGFloat shopH = self.frame.size.height;
    self.iconView.frame = CGRectMake(0, 0, shopW, shopW);
    self.nameLabel.frame = CGRectMake(0, shopW, shopW, shopH - shopW);
}

- (void)setShop:(HCShop *)shop
{
    _shop = shop;
    
    self.nameLabel.text = shop.name;
    self.iconView.image = [UIImage imageNamed:shop.icon];
}



@end
