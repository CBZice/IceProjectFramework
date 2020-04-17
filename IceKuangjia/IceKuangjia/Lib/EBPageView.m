//
//  EBPageView.m
//  ExpressBusiness
//
//  Created by 陈冰泽 on 2018/8/2.
//  Copyright © 2018年 hairong. All rights reserved.
//

#import "EBPageView.h"

@interface EBPageView()<UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *subViews;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *btnArr;
@property (nonatomic, strong) UIButton *selectedBtn;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@end

@implementation EBPageView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles subViews:(NSArray *)subViews {
    if ([super initWithFrame:frame]) {
        _titles = titles;
        _subViews = subViews;
        [self setTitleView];
        [self setScrollView];
    }
    return self;
}

- (void)setTitleView {
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 44)];
    titleView.backgroundColor = BackGroundColor;
    NSArray *segmentedArray = _titles;
    
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    segmentedControl.frame = CGRectMake(15, 5, WIDTH - 30, 34);
    segmentedControl.selectedSegmentIndex = 0;
    segmentedControl.tintColor = kUIColorFromRGB(0x24bba8);
    segmentedControl.backgroundColor = BackGroundColor;
    [segmentedControl addTarget:self action:@selector(indexDidChangeForSegmentedControl:) forControlEvents:UIControlEventValueChanged];
    _segmentedControl = segmentedControl;
    
    [titleView addSubview:segmentedControl];
    [self addSubview:titleView];
}

- (void)setScrollView {
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 44, WIDTH, HEIGHT - 44 - NavHeight)];
    scrollView.pagingEnabled = YES;
    scrollView.scrollEnabled = YES;
    scrollView.bounces = NO;
    scrollView.delegate = self;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.backgroundColor = BackGroundColor;
    
    int i = 0;
    for (UIView *view in _subViews) {
        view.frame = CGRectMake(WIDTH * i, 0, WIDTH, HEIGHT - 44 - NavHeight);
        [scrollView addSubview:view];
        i++;
    }
//    UIView *view1 = _subViews[0];
//    view1.frame = CGRectMake(0, 0, WIDTH, HEIGHT - 44 - NavHeight);
//    UIView *view2 = _subViews[1];
//    view2.frame = CGRectMake(WIDTH, 0, WIDTH, HEIGHT - 44 - NavHeight);
//    [scrollView addSubview:view1];
//    [scrollView addSubview:view2];
    [self addSubview:scrollView];
    scrollView.contentSize = CGSizeMake(WIDTH * _titles.count, HEIGHT - 44 - NavHeight);
    _scrollView = scrollView;
    [self scrollViewDidScroll:scrollView];
}

- (void)indexDidChangeForSegmentedControl:(UISegmentedControl *)sender {
    WeekSelf
    _currectPage = sender.selectedSegmentIndex;
    [UIView animateWithDuration:0.5 animations:^{
        weSelf.scrollView.contentOffset = CGPointMake(WIDTH * sender.selectedSegmentIndex, 0);
    }];
}

- (void)setType:(EBPageViewType)type {
    _type = type;
    [self scrollViewDidScroll:_scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger index = (NSInteger)((scrollView.contentOffset.x)/(CGFloat)WIDTH + 0.5);
    _selectedBtn.selected = NO;
    _selectedBtn = _btnArr[index];
    _selectedBtn.selected = YES;
    _currectPage = index;
    _segmentedControl.selectedSegmentIndex = index;
}

@end
