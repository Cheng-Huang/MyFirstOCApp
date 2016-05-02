 //
//  ViewController.m
//  MyFirstOCApp
//
//  Created by 成 黄 on 16/4/22.
//  Copyright © 2016年 成 黄. All rights reserved.
//

#import "ViewController.h"
#import "HCShopView.h"
#import "HCShop.h"

@interface ViewController ()
/**
 *  存放所有商品的整体
 */
@property (weak, nonatomic) IBOutlet UIView *shopsView;
/**
 *  提示
 */
@property (weak, nonatomic) IBOutlet UILabel *hud;
/**
 *  添加按钮
 */
@property (weak, nonatomic) UIButton *addBtn;
/**
 *  删除按钮
 */
@property (weak, nonatomic) UIButton *removeBtn;
/**
 *  全部商品数据
 *  strong
 */
@property (strong, nonatomic) NSArray *shops;

@end

@implementation ViewController

// 懒加载 重写get方法
- (NSArray *)shops {
    if (_shops == nil) {
        // 加载字典数组
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"shops" ofType:@"plist"]];
        // 将字典转换为模型，组成模型数组
        NSMutableArray *shopArray = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            HCShop *shop = [HCShop shopWithDict:dict];
            [shopArray addObject:shop];
        }
        _shops = shopArray;
    }
    return _shops;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // 加载按钮
    self.addBtn            = [self addBtnWithImage:@"add" imageHighlighted:@"add_highlighted" imageDisabled:@"add_disabled" frame:CGRectMake(30, 30, 64, 64) action:@selector(add)];
    self.removeBtn         = [self addBtnWithImage:@"remove" imageHighlighted:@"remove_highlighted" imageDisabled:@"remove_disabled" frame:CGRectMake(230, 30, 64, 64) action:@selector(remove)];
    self.removeBtn.enabled = NO;
}


#pragma mark - 按钮添加
- (UIButton *)addBtnWithImage:(NSString *)imageNormal imageHighlighted:(NSString *)imageHighlighted imageDisabled:(NSString *)imageDisabled frame:(CGRect)frame action:(SEL)action {
    UIButton *btn = [[UIButton alloc] init];
    [btn setBackgroundImage:[UIImage imageNamed:imageNormal] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:imageHighlighted] forState:UIControlStateHighlighted];
    [btn setBackgroundImage:[UIImage imageNamed:imageDisabled] forState:UIControlStateDisabled];
    btn.frame     = frame;
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    return btn;
}

#pragma mark - 事件触发
- (void)add {

    // 商品空间宽｜高
    CGFloat shopW     = 80;
    CGFloat shopH     = 90;

    // 列数
    int cols          = 3;

    // 间距
    CGFloat colMargin = (self.shopsView.frame.size.width - cols * shopW) / (cols - 1);
    CGFloat rowMargin = colMargin;

    // 商品的索引
    NSUInteger index = self.shopsView.subviews.count;
    
    // 创建商品父控件作为容器
    // HCShopView *shopView = [HCShopView shopView];
    HCShopView *shopView = [HCShopView shopViewWithShop:self.shops[index]];

    
    // 给商品控件传递商品模型
    shopView.shop = self.shops[index];

    // 商品的x值
    NSUInteger col   = index % cols;
    CGFloat shopX    = col * (shopW + colMargin);

    // 商品的y值
    NSUInteger row   = index / cols;
    CGFloat shopY    = row * (shopH + rowMargin);

    // 添加商品控件
    shopView.frame   = CGRectMake(shopX, shopY, shopW, shopH);
    [self.shopsView addSubview:shopView];

    [self checkState];
}

- (void)remove {
    [[self.shopsView.subviews lastObject] removeFromSuperview];
    [self checkState];
}

- (void)checkState {
//    NSLog(@"%d", (int)self.shopsView.subviews.count); // 调试用
    self.removeBtn.enabled    = (self.shopsView.subviews.count > 0);
    self.addBtn.enabled       = (self.shopsView.subviews.count < self.shops.count);
    // 显示HUD
    NSString *text = nil;
    if (self.removeBtn.enabled == NO) {
        text = @"已经全部删除了！";
    } else if (self.addBtn.enabled == NO) {
        text = @"已经添加满了！";
    }
    if (text == nil) return;

    self.hud.text  = text;
    self.hud.alpha = 1.0;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    self.hud.alpha = 0.0;
    });
}

@end
