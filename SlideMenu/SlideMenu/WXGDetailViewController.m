//
//  WXGDetailViewController.m
//  SlideMenu
//
//  Created by Nicholas Chow on 15/7/5.
//  Copyright (c) 2015年 Nicholas Chow. All rights reserved.
//

#import "WXGDetailViewController.h"
#import "WXGMenuItem.h"

@interface WXGDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *detailImage;

@property (nonatomic, weak) UIImageView *hamburger;

@end

@implementation WXGDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // UIBarButtonItem的initWithCustomView:方法会对内部控件有特殊约束
    // 直接将hamburger添加上去会无法实现滚动效果
    // 解决办法：将hamburger包装在一个view里面
    UIView *wrapView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hamburgerClick)];
    [wrapView addGestureRecognizer:tap];
    
    UIImageView *hamburger = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Hamburger"]];
    self.hamburger = hamburger;
    
    [wrapView addSubview:hamburger];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:wrapView];
}

// 顶部hamburger按钮点击事件
- (void)hamburgerClick {
    if (self.hamburgerDidClick) {
        self.hamburgerDidClick();
    }
}

// 顶部hamburger按钮滚动效果
- (void)rotateHamburgerWithScale:(CGFloat)scale {
    CGFloat angle = M_PI_2 * (1 - scale);
    self.hamburger.transform = CGAffineTransformMakeRotation(angle);
}

- (void)setItem:(WXGMenuItem *)item {
    _item = item;
    
    self.detailImage.image = [UIImage imageNamed:item.bigImage];
    CGFloat r = [item.colors[0] doubleValue];
    CGFloat g = [item.colors[1] doubleValue];
    CGFloat b = [item.colors[2] doubleValue];
    self.view.backgroundColor = [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:1];
}

@end
