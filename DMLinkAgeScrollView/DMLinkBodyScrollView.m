//
//  DMLinkBodyScrollView.m
//  DMLinkAgeScrollViewDemo
//
//  Created by Dream on 16/3/28.
//  Copyright © 2016年 Dream. All rights reserved.
//

#import "DMLinkBodyScrollView.h"

@implementation DMLinkBodyScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.layer.masksToBounds = NO;
    }
    
    return self;
}

@end
