//
//  WXGMenuItem.m
//  SlideMenu
//
//  Created by Nicholas Chow on 15/7/5.
//  Copyright (c) 2015年 Nicholas Chow. All rights reserved.
//

#import "WXGMenuItem.h"

@implementation WXGMenuItem

+ (instancetype)itemWithDict:(NSDictionary *)dict {
    WXGMenuItem *item = [[self alloc] init];
    [item setValuesForKeysWithDictionary:dict];
    return item;
}

@end
