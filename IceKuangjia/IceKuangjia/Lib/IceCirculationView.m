//
//  IceCirculationView.m
//  IceScrollView
//
//  Created by sanmi on 16/8/22.
//  Copyright © 2016年 sanmi. All rights reserved.
//

#import "IceCirculationView.h"
#import "UIImageView+WebCache.h"
#import "UIView+Extension.h"

/**
 用于标识中间的图片是数组中的哪一个
 */
static NSInteger indexCount;

@interface IceCirculationView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *myScrollView;

@property (nonatomic, strong) NSMutableArray *imgNameArr;
@property (nonatomic, strong) NSMutableArray *imgViewArr;
@property (nonatomic, strong) NSTimer *timer;
/**
 时间导致的scrollView偏移，不进行自动切换
 */
@property (nonatomic, assign) BOOL isTimer;

@end

@implementation IceCirculationView

-(instancetype)initWithFrame:(CGRect)frame Images:(NSArray *)imageArr{
    if (self = [super initWithFrame:frame]) {
        
        _imgViewArr = [NSMutableArray array];
        
        [self setScrollViewWithFrame:frame];
        
        [self createCirculationViewWithimgArr:imageArr];
        
        [self startTimer];
    }
    return self;
}

//初始化滑动控件
- (void)setScrollViewWithFrame:(CGRect)frame{
    _myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width, frame.size.height)];
    _myScrollView.width = self.width;
    _myScrollView.delegate = self;
    _myScrollView.pagingEnabled = YES;
    _myScrollView.showsHorizontalScrollIndicator = NO;
    _myScrollView.showsVerticalScrollIndicator = NO;
    [_myScrollView setContentOffset:CGPointMake(self.width, 0) animated:NO];
    [self addSubview:_myScrollView];
}

//加载滑动视图上的图片
- (void)createCirculationViewWithimgArr:(NSArray *)imgArr{
    _imgNameArr = [NSMutableArray arrayWithArray:imgArr];
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.height - 10, self.width, 0)];
    _pageControl.numberOfPages = imgArr.count;
    [self addSubview:_pageControl];
    
    NSInteger imgCount = 3;
    
    for (int i = 0; i < imgCount; i++) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(i * self.width, 0, self.width, _myScrollView.height)];
        NSString *str = nil;
        if (i == 0) {
            str = imgArr[imgArr.count - 1];
        }else{
            str = imgArr[i - 1];
        }
        UIImage *placeImg = self.placeHolder.length != 0 ? [UIImage imageNamed:self.placeHolder]:nil;
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:str]]) {
            [imgView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:placeImg];
        }else{
            imgView.image = [UIImage imageNamed:str];
        }
        [_imgViewArr addObject:imgView];
        [_myScrollView addSubview:imgView];
        
        if (i == 1) {
            UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchPic)];
            [imgView addGestureRecognizer:ges];
            
            imgView.userInteractionEnabled = YES;
        }
    }
    _myScrollView.contentSize = CGSizeMake(self.width * imgCount, _myScrollView.height);
}
- (void)changgePage{
    if (indexCount < 0) {
        indexCount = _imgNameArr.count + indexCount;
    }
    indexCount ++;
    if (indexCount == _imgNameArr.count) {
        indexCount = 0;
    }
    _pageControl.currentPage = indexCount;
    [UIView animateWithDuration:.5 animations:^{
        _myScrollView.contentOffset = CGPointMake(self.width * 2, 0);
    } completion:^(BOOL finished) {
        [self setScrollViewContentOffSetWithScrollView:_myScrollView];
    }];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self startTimer];
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopTimer];
}

#pragma mark - 滑动时调用
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_isTimer)return;
    if (scrollView.contentOffset.x/self.width >= 2) {
        if (indexCount < 0) {
            indexCount = _imgNameArr.count + indexCount;
        }
        indexCount ++;
        if (indexCount == _imgNameArr.count) {
            indexCount = 0;
        }
        _pageControl.currentPage = indexCount;
        [self setScrollViewContentOffSetWithScrollView:scrollView];
        
    }else if (scrollView.contentOffset.x/self.width <= 0){
        if (indexCount > 0) {
            indexCount =  indexCount - _imgNameArr.count;
        }
        indexCount --;
        if (indexCount == -_imgNameArr.count) {
            indexCount = 0;
            _pageControl.currentPage = indexCount;
        }else{
            _pageControl.currentPage = _imgNameArr.count + indexCount;
        }
        [self setScrollViewContentOffSetWithScrollView:scrollView];
    }
}

- (void)setScrollViewContentOffSetWithScrollView:(UIScrollView *)scrollView
{
    for (int i = 0; i < 3; i++) {
        NSInteger index = (indexCount - 1 + i)%_imgNameArr.count;
        if (indexCount < 0) {
            index = (_imgNameArr.count + indexCount - 1 + i)%_imgNameArr.count;
        }
        UIImageView *imgView = _imgViewArr[i];
        NSString *str = _imgNameArr[index];
        if (indexCount == 0 && i == 0) {
            str = _imgNameArr[_imgNameArr.count - 1];
        }
        UIImage *placeImg = self.placeHolder.length != 0 ? [UIImage imageNamed:self.placeHolder]:nil;
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:str]]) {
            [imgView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:placeImg];
        }else{
            imgView.image = [UIImage imageNamed:str];
        }
    }
    [scrollView setContentOffset:CGPointMake(self.width, 0) animated:NO];
}

//设置定时器时间时，重启计时器
-(void)setAnimationDelay:(CGFloat)animationDelay
{
    _animationDelay = animationDelay;
    [self stopTimer];
    [self startTimer];
}

/**
 开始计时器
 */
- (void)startTimer{
    _isTimer = YES;
    
    CGFloat duraion = self.animationDelay == 0 ? 1.5 : self.animationDelay;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:duraion target:self selector:@selector(changgePage) userInfo:nil repeats:YES];
    //防止进入后台再次进入时，停止运行
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}
/**
 结束计时器
 */
- (void)stopTimer{
    _isTimer = NO;
    [_timer invalidate];
    _timer = nil;
}

- (void)touchPic{
    if ([self.delegate respondsToSelector:@selector(whichPicureBeChanged:)]) {
        if (indexCount < 0) {
            indexCount = _imgNameArr.count + indexCount;
        }
        [self.delegate whichPicureBeChanged:indexCount];
    }
}

-(NSInteger)currectPage
{
    return self.pageControl.currentPage;
}

@end
