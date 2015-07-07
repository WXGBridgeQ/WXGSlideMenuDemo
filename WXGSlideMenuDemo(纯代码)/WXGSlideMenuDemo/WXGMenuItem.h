//
//  WXGMenuItem.h
//  SlideMenu
//
//  Created by Nicholas Chow on 15/7/5.
//  Copyright (c) 2015年 Nicholas Chow. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WXGMenuItem : NSObject

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *bigImage;

@property (nonatomic, copy) NSArray *colors;

+ (instancetype)itemWithDict:(NSDictionary *)dict;

@end
