//
//  WXGMenuViewController.h
//  WXGSlideMenuDemo
//
//  Created by Nicholas Chow on 15/7/6.
//  Copyright (c) 2015年 Nicholas Chow. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WXGMenuItem;

@interface WXGMenuViewController : UITableViewController

/**
 * 注册菜单视图的点击事件
 */
@property (nonatomic, copy) void(^menuDidClick)(WXGMenuItem *item, BOOL animated);

@end
