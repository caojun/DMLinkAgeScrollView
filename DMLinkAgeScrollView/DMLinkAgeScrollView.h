//
//  DMLinkAgeScrollView.h
//  DMLinkAgeScrollViewDemo
//
//  Created by Dream on 16/3/17.
//  Copyright © 2016年 Dream. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class DMLinkAgeScrollView;

@protocol DMLinkAgeScrollViewDataSource <NSObject>

@required
- (CGFloat)linkAgeScrollViewTopHeight:(nonnull DMLinkAgeScrollView *)view;

- (nonnull UIView *)linkAgeScrollViewTopView:(DMLinkAgeScrollView *)view;
- (nonnull UIScrollView *)linkAgeScrollViewBodyView:(DMLinkAgeScrollView *)view;

@end

@interface DMLinkAgeScrollView : UIView

@property (nullable, nonatomic, weak) id<DMLinkAgeScrollViewDataSource> dataSource;

- (void)loadData;

- (void)adjustView;

@end

NS_ASSUME_NONNULL_END
