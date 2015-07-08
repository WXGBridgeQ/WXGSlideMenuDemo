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

@property (nonatomic, weak) UIImageView *leftBarIcon;

@end

@implementation WXGDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 去掉导航条下面的阴影效果的那条线
    self.navigationController.navigationBar.clipsToBounds = YES;
    
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
    
    self.detailImage.image = [UIImage imageNamed:item.bigImage];
    CGFloat r = [item.colors[0] doubleValue];
    CGFloat g = [item.colors[1] doubleValue];
    CGFloat b = [item.colors[2] doubleValue];
    self.view.backgroundColor = [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:1];
}

@end
