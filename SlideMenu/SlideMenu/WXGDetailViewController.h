//
//  WXGDetailViewController.h
//  SlideMenu
//
//  Created by Nicholas Chow on 15/7/5.
//  Copyright (c) 2015年 Nicholas Chow. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WXGMenuItem;

@interface WXGDetailViewController : UIViewController

@property (nonatomic, strong) WXGMenuItem *item;

// 注册顶部hamburger按钮点击事件
@property (nonatomic, copy) void(^hamburgerDidClick)();

// 顶部hamburger按钮滚动效果
- (void)rotateHamburgerWithScale:(CGFloat)scale;

@end
