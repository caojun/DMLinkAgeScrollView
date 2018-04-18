//
//  ViewController.m
//  DMLinkAgeScrollViewDemo
//
//  Created by Dream on 16/3/17.
//  Copyright © 2016年 Dream. All rights reserved.
//

#import "ViewController.h"
#import "DMLinkAgeScrollView.h"
#import "DMScrollView.h"
#import "DMLinkTableView.h"

#define MAIN_SCR_W              ([UIScreen mainScreen].bounds.size.width)
#define MAIN_SCR_H              ([UIScreen mainScreen].bounds.size.height)

#define TopViewHeight           180

@interface ViewController () <DMLinkAgeScrollViewDataSource, UITableViewDataSource, UITableViewDelegate>

@property (nullable, nonatomic, weak) DMLinkAgeScrollView *m_linkAgeView;

@property (nullable, nonatomic, weak) UITableView *m_tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect frame = [UIScreen mainScreen].bounds;
    
#if 1
    DMLinkAgeScrollView *view = [[DMLinkAgeScrollView alloc] initWithFrame:frame];
    [self.view addSubview:view];
    view.dataSource = self;
    self.m_linkAgeView = view;
    view.backgroundColor = [UIColor clearColor];
#else
    frame.origin.y = 100;
    frame.size.height -= frame.origin.y;
    UITableView *tableView = [[UITableView alloc] initWithFrame:frame];
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.layer.masksToBounds = NO;
    tableView.backgroundView = nil;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.m_tableView = tableView;
#endif
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
//    UIView *view = self.m_tableView.subviews.firstObject;
//    NSLog(@"%@", view);
//    NSLog(@"%@", @(view.layer.masksToBounds));
//    NSLog(@"%@", @(view.clipsToBounds));
//    
//    NSLog(@"%@", self.m_tableView);
//    NSLog(@"%@", @(view.layer.masksToBounds));
//    
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//    UITableViewCell *cell = [self.m_tableView cellForRowAtIndexPath:indexPath];
//    NSLog(@"%@", cell.superview);
//    NSLog(@"%@", cell.superview.superview);
//    NSLog(@"%@", cell.superview.superview.superview);
}


#pragma mark - DMLinkAgeScrollViewDataSource
- (CGFloat)linkAgeScrollViewTopHeight:(nonnull DMLinkAgeScrollView *)view
{
    return TopViewHeight;
}


- (nonnull UIView *)linkAgeScrollViewTopView:(DMLinkAgeScrollView *)view
{
    UIButton *topView = [UIButton buttonWithType:UIButtonTypeCustom];
    [topView addTarget:self action:@selector(topBtnClick) forControlEvents:UIControlEventTouchUpInside];
    topView.backgroundColor = [UIColor orangeColor];
    [topView setTitle:@"button" forState:UIControlStateNormal];
    topView.frame = (CGRect){0, 0, MAIN_SCR_W, TopViewHeight};
    
    return topView;
}

- (void)topBtnClick
{
    NSLog(@"topBtnClick.....");
}

- (nonnull UIScrollView *)linkAgeScrollViewBodyView:(DMLinkAgeScrollView *)view
{
#if 0
    UITableView *tableView = [[DMLinkTableView alloc] init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.layer.masksToBounds = NO;
    
    return tableView;
#else
    CGFloat height = 900;
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.4];
    scrollView.contentSize = CGSizeMake(MAIN_SCR_W, height);
    scrollView.delegate = self;
    
    CGRect imageFrame = {0, 0, MAIN_SCR_W, height};
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:imageFrame];
    imageView.image = [UIImage imageNamed:@"pic"];
    imageView.backgroundColor = [UIColor redColor];
    imageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTap)];
    [imageView addGestureRecognizer:tap];
    
    CGRect tableFrame = {0, 0, MAIN_SCR_W, MAIN_SCR_H - TopViewHeight};
    UITableView *tableView = [[DMLinkTableView alloc] initWithFrame:tableFrame];
    tableView.delegate = self;
    tableView.dataSource = self;
//    tableView.userInteractionEnabled = NO;
    
//    [scrollView addSubview:imageView];
    [scrollView addSubview:tableView];
    CGFloat contentHeight = 0;
    NSInteger numberSection = 1;
    if ([tableView.dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)])
    {
        numberSection = [tableView.dataSource numberOfSectionsInTableView:tableView];
    }
    
    for (NSInteger i=0; i<numberSection; i++)
    {
        if ([tableView.delegate respondsToSelector:@selector(tableView:heightForHeaderInSection:)])
        {
            contentHeight += [tableView.delegate tableView:tableView heightForHeaderInSection:i];
        }
        
        if ([tableView.delegate respondsToSelector:@selector(tableView:heightForFooterInSection:)])
        {
            contentHeight += [tableView.delegate tableView:tableView heightForFooterInSection:i];
        }
        
        NSInteger row = [tableView.dataSource tableView:tableView numberOfRowsInSection:i];
        for (NSInteger j=0; j<row; j++)
        {
            if ([tableView.delegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)])
            {
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:j inSection:i];
                contentHeight += [tableView.delegate tableView:tableView heightForRowAtIndexPath:indexPath];
            }
            else
            {
                contentHeight += 44;
            }
        }
    }
    
    scrollView.contentSize = CGSizeMake(MAIN_SCR_W, contentHeight);
    
    return scrollView;
#endif
}

- (void)imageViewTap
{
    NSLog(@"imageViewTap");
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.m_linkAgeView adjustView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *const kIdentifier = @"cellId";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kIdentifier];
    if (nil == cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kIdentifier];
    }
    
    cell.textLabel.text = [@(indexPath.row) description];
    
    return cell;
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelectRow");
}


@end
