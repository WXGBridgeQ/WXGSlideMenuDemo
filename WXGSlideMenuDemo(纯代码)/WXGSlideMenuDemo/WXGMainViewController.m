//
//  WXGMainViewController.m
//  WXGSlideMenuDemo
//
//  Created by Nicholas Chow on 15/7/6.
//  Copyright (c) 2015年 Nicholas Chow. All rights reserved.
//

#import "WXGMainViewController.h"
#import "WXGMenuViewController.h"
#import "WXGDetailViewController.h"
#import "WXGMenuItem.h"

@interface WXGMainViewController () <UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) WXGMenuViewController *menuViewController;
@property (nonatomic, weak) WXGDetailViewController *detailViewController;

@property (nonatomic, getter=isShowMenu) BOOL showMenu;

@end

static const CGFloat kMenuWidth = 80;

@implementation WXGMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupScrollView];
    
    [self setupChildViewController];
    
    [self setupChildView];
}

- (void)setupScrollView {
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView = scrollView;
    scrollView.contentSize = CGSizeMake(CGRectGetWidth(scrollView.bounds) + kMenuWidth, CGRectGetHeight(scrollView.bounds));
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.bounces = NO;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
}

- (void)setupChildViewController {
    WXGMenuViewController *menuViewController = [[WXGMenuViewController alloc] init];
    self.menuViewController = menuViewController;
    UINavigationController *menuNavigationController = [[UINavigationController alloc] initWithRootViewController:menuViewController];
    [self addChildViewController:menuNavigationController];
    
    WXGDetailViewController *detailViewController = [[WXGDetailViewController alloc] init];
    self.detailViewController = detailViewController;
    UINavigationController *detailNavigationController = [[UINavigationController alloc] initWithRootViewController:detailViewController];
    [self addChildViewController:detailNavigationController];
    
    // 设置导航条样式
    menuNavigationController.navigationBar.barStyle = UIBarStyleBlack;
    detailNavigationController.navigationBar.barStyle = UIBarStyleBlack;
    // 设置导航条的透明效果，translucent设置为NO时，表示view不会再穿透导航条，所以会下移64
    menuNavigationController.navigationBar.translucent = NO;
    detailNavigationController.navigationBar.translucent = NO;
    // 去掉导航条下面的阴影效果的那条线
    menuNavigationController.navigationBar.clipsToBounds = YES;
    detailNavigationController.navigationBar.clipsToBounds = YES;
    
    // 注册菜单视图的点击事件
    menuViewController.menuDidClick = ^(WXGMenuItem *item, BOOL animated) {
        detailViewController.item = item;
        [self showOrHideMenu:NO animated:animated];
    };
    
    // 注册顶部按钮的点击事件
    detailViewController.leftBarButtonDidClick = ^() {
        [self showOrHideMenu:!self.isShowMenu animated:YES];
    };
}

- (void)setupChildView {
    self.menuViewController.parentViewController.view.frame = CGRectMake(0, 0, kMenuWidth, CGRectGetHeight(self.scrollView.bounds));
    [self.scrollView addSubview:self.menuViewController.parentViewController.view];
    
    self.detailViewController.parentViewController.view.frame = CGRectMake(kMenuWidth, 0, CGRectGetWidth(self.scrollView.bounds), CGRectGetHeight(self.scrollView.bounds));
    [self.scrollView addSubview:self.detailViewController.parentViewController.view];
    
    // 为菜单视图的旋转设置锚点
    self.menuViewController.view.layer.anchorPoint = CGPointMake(1, 0.5);
}

- (void)showOrHideMenu:(BOOL)showOrHide animated:(BOOL)animated {
    [self.scrollView setContentOffset:showOrHide ? CGPointZero : CGPointMake(kMenuWidth, 0) animated:animated];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 解决菜单隐藏后点击detailView会自动显示菜单的bug，bug原因与pagingEnabled有关，还没太弄清楚，感兴趣的同学可自行查看
    // http://stackoverflow.com/questions/4480512/uiscrollview-single-tap-scrolls-it-to-top
    scrollView.pagingEnabled = scrollView.contentOffset.x < kMenuWidth;
    
    // 控制菜单显示与否的状态
    self.showMenu = scrollView.contentOffset.x < kMenuWidth;
    
    CGFloat scale = scrollView.contentOffset.x / kMenuWidth;
    
    // 菜单视图的翻页效果
    self.menuViewController.view.layer.transform = [self transformWithScale:scale];
    self.menuViewController.view.alpha = 1 - scale;
    
    // 顶部按钮的滚动效果
    [self.detailViewController rotateLeftBarButtonWithScale:scale];
}

// 菜单视图的翻页效果
- (CATransform3D)transformWithScale:(CGFloat)scale {
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1 / 1000.0; // 3D效果
    CGFloat angle = -M_PI_2 * scale;
    CATransform3D rotation = CATransform3DRotate(transform, angle, 0, 1, 0);
    return rotation;
}

@end
