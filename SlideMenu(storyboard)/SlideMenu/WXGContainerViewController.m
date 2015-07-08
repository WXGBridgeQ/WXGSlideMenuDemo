//
//  WXGContainerViewController.m
//  SlideMenu
//
//  Created by Nicholas Chow on 15/7/5.
//  Copyright (c) 2015年 Nicholas Chow. All rights reserved.
//

#import "WXGContainerViewController.h"
#import "WXGMenuViewController.h"
#import "WXGDetailViewController.h"
#import "WXGMenuItem.h"

@interface WXGContainerViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *menuContainerView;

@property (nonatomic, weak) WXGMenuViewController *menuViewController;
@property (nonatomic, weak) WXGDetailViewController *detailViewController;

@property (nonatomic, getter=isShowMenu) BOOL showMenu;

@end

static const CGFloat kMenuWidth = 80;

@implementation WXGContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 注册菜单视图的点击事件
    self.menuViewController.menuDidClick = ^(WXGMenuItem *item, BOOL animated) {
        self.detailViewController.item = item;
        [self showOrHideMenu:NO animated:animated];
    };
    
    // 注册顶部按钮的点击事件
    self.detailViewController.leftBarButtonDidClick = ^() {
        [self showOrHideMenu:!self.isShowMenu animated:YES];
    };
}

// 控制菜单视图显示与隐藏
- (void)showOrHideMenu:(BOOL)showOrHide animated:(BOOL)animated {
    [self.scrollView setContentOffset:showOrHide ? CGPointZero : CGPointMake(kMenuWidth, 0) animated:animated];
}

// 监听视图滑动
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
    transform.m34 = -1 / 1000.0;
    CGFloat angle = -M_PI_2 * scale;
    CATransform3D rotation = CATransform3DRotate(transform, angle, 0, 1, 0);
    return rotation;
}

// 获取两个子控制器
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"MenuViewControllerSegue"]) {
        self.menuViewController = (WXGMenuViewController *)[segue.destinationViewController topViewController];
    } else if ([segue.identifier isEqualToString:@"DetailViewControllerSegue"]) {
        self.detailViewController = (WXGDetailViewController *)[segue.destinationViewController topViewController];
    }
}

// 更改状态栏样式
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
