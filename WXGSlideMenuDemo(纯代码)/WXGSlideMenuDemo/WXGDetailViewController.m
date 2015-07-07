//
//  WXGDetailViewController.m
//  WXGSlideMenuDemo
//
//  Created by Nicholas Chow on 15/7/6.
//  Copyright (c) 2015年 Nicholas Chow. All rights reserved.
//

#import "WXGDetailViewController.h"
#import "WXGMenuItem.h"

@interface WXGDetailViewController ()

@property (nonatomic, weak) UIImageView *detailIcon;

@property (nonatomic, weak) UIImageView *leftBarIcon;

@end

@implementation WXGDetailViewController

- (UIImageView *)detailIcon {
    if (!_detailIcon) {
        UIImageView *detailIcon = [[UIImageView alloc] init];
        _detailIcon = detailIcon;
        [self.view addSubview:detailIcon];
    }
    return _detailIcon;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // UIBarButtonItem的initWithCustomView:方法会对内部控件有特殊约束
    // 直接将leftBarIcon添加上去会无法实现滚动效果
    // 解决办法：将leftBarIcon包装在一个view里面
    UIView *wrapView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftBarButtonClick)];
    [wrapView addGestureRecognizer:tap];
    
    UIImageView *leftBarIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Hamburger"]];
    self.leftBarIcon = leftBarIcon;
    
    [wrapView addSubview:leftBarIcon];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:wrapView];
}

// 使用自定义视图时，在初始化方法中通常无法获取真实的frame，所以我们经常在layoutSubviews方法中布局子控件，此处同理
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.detailIcon.frame = CGRectMake((CGRectGetWidth(self.view.bounds) - 320) * 0.5, (CGRectGetHeight(self.view.bounds) - 320) * 0.5, 320, 320);
}

// 顶部按钮点击事件
- (void)leftBarButtonClick {
    if (self.leftBarButtonDidClick) {
        self.leftBarButtonDidClick();
    }
}

// 顶部按钮滚动效果
- (void)rotateLeftBarButtonWithScale:(CGFloat)scale {
    CGFloat angle = M_PI_2 * (1 - scale);
    self.leftBarIcon.transform = CGAffineTransformMakeRotation(angle);
}

- (void)setItem:(WXGMenuItem *)item {
    _item = item;
    
    self.detailIcon.image = [UIImage imageNamed:item.bigImage];
    CGFloat r = [item.colors[0] doubleValue] / 255.0;
    CGFloat g = [item.colors[1] doubleValue] / 255.0;
    CGFloat b = [item.colors[2] doubleValue] / 255.0;
    self.view.backgroundColor = [UIColor colorWithRed:r green:g blue:b alpha:1.0];
}

@end
