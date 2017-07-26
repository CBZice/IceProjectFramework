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



@interface IceCirculationView ()<UIScrollViewDelegate>
{
    /**
     用于标识中间的图片是数组中的哪一个
     */
    NSInteger indexCount;
}
@property (nonatomic, strong) UIScrollView *myScrollView;

@property (nonatomic, strong) NSMutableArray *imgNameArr;
@property (nonatomic, strong) NSMutableArray *imgViewArr;
@property (nonatomic, strong) NSMutableArray *imagesArr;
@property (nonatomic, strong) NSTimer *timer;

/**
 时间导致的scrollView偏移，不进行自动切换
 */
@property (nonatomic, assign) BOOL isTimer;

/**
在前一次移动未执行完之前，不进行第二次 indexCount++ 操作
 */
@property (nonatomic, assign) BOOL shouldStop;

@end

@implementation IceCirculationView

-(instancetype)initWithFrame:(CGRect)frame Images:(NSArray *)imageArr{
    if (self = [super initWithFrame:frame]) {
        
        indexCount = 0;
        
        _imgViewArr = [NSMutableArray array];
        _imagesArr = [NSMutableArray array];
        
        // 初始化滚动视图
        [self setScrollViewWithFrame:frame];
        
        // 在滚动视图上添加三个 imgView
        [self createCirculationViewWithimgArr:imageArr];
        
        // 在 imgView 上添加 image
        [self setScrollViewContentOffSetWithScrollView:_myScrollView];
        
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
    _isTimer = YES;
    
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

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self startTimer];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopTimer];
}

#pragma mark - 滑动时调用
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_isTimer || _shouldStop)return;
    if (scrollView.contentOffset.x >= self.width*2) {
        indexCount ++;
        if (indexCount == _imgNameArr.count) {
            indexCount = 0;
        }
        [self setPageAndChangeOffset];
    }else if (scrollView.contentOffset.x <= 0){
        indexCount --;
        if (indexCount < 0) {
            indexCount = _imgNameArr.count - 1;
        }
        [self setPageAndChangeOffset];
    }
}

- (void)setPageAndChangeOffset{
    _pageControl.currentPage = indexCount;
    _shouldStop = YES;
    [self setScrollViewContentOffSetWithScrollView:_myScrollView];
}

- (void)setScrollViewContentOffSetWithScrollView:(UIScrollView *)scrollView
{
    [scrollView setContentOffset:CGPointMake(self.width, 0)];
    NSInteger totalCount = _imgNameArr.count;
    NSInteger afterIndex;
    NSInteger laterIndex;
    for (int i = 0; i < 3; i++) {
        afterIndex = indexCount - 1;
        laterIndex = indexCount + 1;
        
        if (afterIndex < 0) {
            afterIndex = totalCount - 1;
        }
        if (laterIndex == totalCount) {
            laterIndex = 0;
        }
        
        
        UIImageView *imgView = _imgViewArr[i];
        NSString *str = nil;
        switch (i) {
            case 0:
                str = _imgNameArr[afterIndex];
                break;
            case 1:
                str = _imgNameArr[indexCount];
                break;
            case 2:
                str = _imgNameArr[laterIndex];
                break;
                
            default:
                break;
        }
        
        UIImage *placeImg = self.placeHolder.length != 0 ? [UIImage imageNamed:self.placeHolder]:nil;
        
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:str]]) {
            [imgView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:placeImg];
        }else{
            imgView.image = [UIImage imageNamed:str];
        }
    }
    _shouldStop = NO;
}

//设置定时器时间时，重启计时器
-(void)setAnimationDelay:(CGFloat)animationDelay
{
    _animationDelay = animationDelay;
    [self startTimer];
}

/**
 开始计时器
 */
- (void)startTimer{
    
    if (_timer) [self stopTimer];
    
    CGFloat duraion = self.animationDelay == 0 ? 2 : self.animationDelay;
    
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
    if ([self.delegate respondsToSelector:@selector(iceCirculationView: whichPicureBeChanged:)]) {
        [self.delegate iceCirculationView:self whichPicureBeChanged:indexCount];
    }
}

-(NSInteger)currectPage
{
    return self.pageControl.currentPage;
}
@end
