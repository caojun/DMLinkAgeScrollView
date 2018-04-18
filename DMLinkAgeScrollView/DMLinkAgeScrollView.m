//
//  DMLinkAgeScrollView.m
//  DMLinkAgeScrollViewDemo
//
//  Created by Dream on 16/3/17.
//  Copyright © 2016年 Dream. All rights reserved.
//

#import "DMLinkAgeScrollView.h"

@interface DMLinkAgeScrollView ()

@property (nullable, nonatomic, strong) UIView *m_topView;
@property (nonatomic, assign) CGFloat m_topHeight;

@property (nullable, nonatomic, strong) UIScrollView *m_bodyView;
@property (nonatomic, assign) CGFloat m_bodyHeight;

@end

@implementation DMLinkAgeScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self loadData];
        });
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self loadData];
        });
    }
    
    return self;
}

- (void)dealloc
{
    //
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    CGFloat viewWidth = CGRectGetWidth(self.bounds);
    
    if (![self.subviews containsObject:self.m_bodyView])
    {
        [self addSubview:self.m_bodyView];
    }
    
    //self.m_topHeight
    self.m_bodyView.frame = (CGRect){0, self.m_topHeight, viewWidth, self.m_bodyHeight};
    
    
    if (![self.subviews containsObject:self.m_topView])
    {
        [self addSubview:self.m_topView];
    }
    
    self.m_topView.frame = (CGRect){0, 0, viewWidth, self.m_topHeight};
    
    self.m_bodyView.layer.masksToBounds = NO;
}

- (void)loadData
{
    self.m_topHeight = [self.dataSource linkAgeScrollViewTopHeight:self];
    self.m_topView = [self.dataSource linkAgeScrollViewTopView:self];
    
    self.m_bodyHeight = CGRectGetHeight(self.frame) - self.m_topHeight;
    self.m_bodyView = [self.dataSource linkAgeScrollViewBodyView:self];
    self.m_bodyView.clipsToBounds = NO;
    
    [self setNeedsLayout];
}

- (void)adjustView
{
    CGFloat offsetY = self.m_bodyView.contentOffset.y;
    
    if (offsetY > self.m_topHeight)
    {
        [self adjustSubViewsWithOffsetY:-self.m_topHeight];
    }
    else
    {
        [self adjustSubViewsWithOffsetY:-offsetY];
    }
}

- (void)adjustSubViewsWithOffsetY:(CGFloat)offsetY
{
//    NSLog(@"offsetY = %@", @(offsetY));
    
    if (offsetY < -self.m_topHeight)
    {
        offsetY = -self.m_topHeight;
    }
    else if (offsetY > 0)
    {
        offsetY = 0;
    }
    
    CGRect frame = self.m_topView.frame;
    frame.origin.y = offsetY;
    self.m_topView.frame = frame;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    __block UIView *tapView = [super hitTest:point withEvent:event];
    if (self == tapView)
    {
        [self.m_bodyView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj pointInside:point withEvent:event])
            {
                tapView = obj;
                *stop = YES;
            }
        }];
    }
    
    return tapView;
}

@end
