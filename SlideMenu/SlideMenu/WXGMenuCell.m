//
//  WXGMenuCell.m
//  SlideMenu
//
//  Created by Nicholas Chow on 15/7/5.
//  Copyright (c) 2015年 Nicholas Chow. All rights reserved.
//

#import "WXGMenuCell.h"
#import "WXGMenuItem.h"

@interface WXGMenuCell ()

@property (weak, nonatomic) IBOutlet UIImageView *menuIcon;

@end

@implementation WXGMenuCell

- (void)setItem:(WXGMenuItem *)item {
    _item = item;
    
    self.menuIcon.image = [UIImage imageNamed:item.image];
    CGFloat r = [item.colors[0] doubleValue];
    CGFloat g = [item.colors[1] doubleValue];
    CGFloat b = [item.colors[2] doubleValue];
    self.backgroundColor = [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:1];
}

@end
