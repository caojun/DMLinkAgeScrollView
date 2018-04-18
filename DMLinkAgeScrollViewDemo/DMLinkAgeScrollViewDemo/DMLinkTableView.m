//
//  DMLinkTableView.m
//  DMLinkAgeScrollViewDemo
//
//  Created by Dream on 16/3/28.
//  Copyright © 2016年 Dream. All rights reserved.
//

#import "DMLinkTableView.h"

@implementation DMLinkTableView

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.layer.masksToBounds = NO;
    
    UIView *view = self.subviews.firstObject;
    if ([NSStringFromClass([view class]) isEqualToString:@"UITableViewWrapperView"])
    {
        view.layer.masksToBounds = NO;
    }
}

@end
