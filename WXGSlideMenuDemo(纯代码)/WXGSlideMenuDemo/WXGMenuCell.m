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

@property (nonatomic, weak) UIImageView *menuIcon;

@end

@implementation WXGMenuCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView *menuIcon = [[UIImageView alloc] init];
        self.menuIcon = menuIcon;
        [self addSubview:menuIcon];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.menuIcon.frame = self.bounds;
}

- (void)setItem:(WXGMenuItem *)item {
    _item = item;
    
    self.menuIcon.image = [UIImage imageNamed:item.image];
    CGFloat r = [item.colors[0] doubleValue] / 255.0;
    CGFloat g = [item.colors[1] doubleValue] / 255.0;
    CGFloat b = [item.colors[2] doubleValue] / 255.0;
    self.backgroundColor = [UIColor colorWithRed:r green:g blue:b alpha:1.0];
}

@end
