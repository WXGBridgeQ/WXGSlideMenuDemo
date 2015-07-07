//
//  WXGMenuViewController.m
//  WXGSlideMenuDemo
//
//  Created by Nicholas Chow on 15/7/6.
//  Copyright (c) 2015年 Nicholas Chow. All rights reserved.
//

#import "WXGMenuViewController.h"
#import "WXGMenuCell.h"
#import "WXGMenuItem.h"

@interface WXGMenuViewController ()

@property (nonatomic, copy) NSArray *menuItems;

@end

static NSString *const identifier = @"cell";

@implementation WXGMenuViewController

- (NSArray *)menuItems {
    if (!_menuItems) {
        NSArray *dicts = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"MenuItems" ofType:@"plist"]];
        NSMutableArray *array = @[].mutableCopy;
        for (NSDictionary *dict in dicts) {
            WXGMenuItem *item = [WXGMenuItem itemWithDict:dict];
            [array addObject:item];
        }
        _menuItems = array.copy;
    }
    return _menuItems;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[WXGMenuCell class] forCellReuseIdentifier:identifier];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.bounces = NO;
    
    // 加载后默认点击第一行，让detailView显示第一行的内容
    self.menuDidClick(self.menuItems[0], NO);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.menuItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WXGMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.item = self.menuItems[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return MAX(80, CGRectGetHeight(self.tableView.bounds) / self.menuItems.count);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.menuDidClick) {
        self.menuDidClick(self.menuItems[indexPath.row], YES);
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
