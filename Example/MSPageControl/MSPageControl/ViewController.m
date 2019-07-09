//
//  ViewController.m
//  MSPageControl
//
//  Created by lztb on 2019/6/27.
//  Copyright © 2019 lztbwlkj. All rights reserved.
//

#import "ViewController.h"
#import "MSPageControl.h"

@interface ViewController ()<UIScrollViewDelegate,MSPageControlDelegate>
@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) UIScrollView *scrollView2;
@property(nonatomic, strong) UIScrollView *scrollView3;
@property(nonatomic, strong) UIScrollView *scrollView4;
@property(nonatomic, strong) UIScrollView *scrollView5;
@property(nonatomic, strong) UIScrollView *scrollView6;

@property (nonatomic, strong) MSPageControl *pageControl;
@property (nonatomic, strong) MSPageControl *pageControl2;
@property (nonatomic, strong) MSPageControl *pageControl3;
@property (nonatomic, strong) MSPageControl *pageControl4;
@property (nonatomic, strong) MSPageControl *pageControl5;
@property (nonatomic, strong) MSPageControl *pageControl6;

@end

@implementation ViewController
#define SCREEN_WIDTH     [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT    [UIScreen mainScreen].bounds.size.height


- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor darkGrayColor];
    int pageCount = 5;
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH, 100)];
    self.scrollView.delegate = self;
    self.scrollView.bounces = NO;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * pageCount, 100);
    for (int index = 0; index < pageCount; index++) {
        CGFloat random = arc4random()%255;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(index*SCREEN_WIDTH, 0, SCREEN_WIDTH, 100)];
        imageView.backgroundColor = [UIColor colorWithRed:random/255 green:random/255 blue:random/255 /255 alpha:1];
        [self.scrollView addSubview:imageView];
    }
    
    self.pageControl = [MSPageControl pageControlSystemWithFrame:CGRectMake(0, CGRectGetMaxY(self.scrollView.frame), SCREEN_WIDTH, 25) numberOfPages:pageCount otherDotColor:[UIColor blueColor] currentDotColor:[UIColor redColor]];
    self.pageControl.delegate = self;
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.pageControl];
    
    
    
#pragma mark - scrollView2
    self.scrollView2 = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.pageControl.frame) + 10, SCREEN_WIDTH, 100)];
    self.scrollView2.delegate = self;
    self.scrollView2.bounces = NO;
    self.scrollView2.pagingEnabled = YES;
    self.scrollView2.contentSize = CGSizeMake(SCREEN_WIDTH * pageCount, 100);
    for (int index = 0; index < pageCount; index++) {
        CGFloat random = arc4random()%255;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(index*SCREEN_WIDTH, 0, SCREEN_WIDTH, 100)];
        imageView.backgroundColor = [UIColor colorWithRed:random/255 green:random/255 blue:random/255 /255 alpha:1];
        [self.scrollView2 addSubview:imageView];
    }
    [self.view addSubview:self.scrollView2];

    self.pageControl2 = [[MSPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.scrollView2.frame), SCREEN_WIDTH, 25)];
    self.pageControl2.numberOfPages = pageCount;//
    self.pageControl2.dotBorderColor = [UIColor whiteColor];
    self.pageControl2.dotBorderWidth = 1;
    self.pageControl2.currentDotBorderColor = [UIColor redColor];
    self.pageControl2.currentDotBorderWidth = 1;
    __weak __typeof(self)weakSelf = self;
    self.pageControl2.didSelectPageAtIndexBlock = ^(MSPageControl * _Nonnull pageControl, NSInteger index) {
        [weakSelf.scrollView2 setContentOffset:CGPointMake(SCREEN_WIDTH * index, 0) animated:YES];
    };
    [self.view addSubview:self.pageControl2];
    
    
#pragma mark - scrollView3
    self.scrollView3 = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.pageControl2.frame), SCREEN_WIDTH, 100)];
    self.scrollView3.delegate = self;
    self.scrollView3.bounces = NO;
    self.scrollView3.pagingEnabled = YES;
    self.scrollView3.contentSize = CGSizeMake(SCREEN_WIDTH * pageCount, 100);
    for (int index = 0; index < pageCount; index++) {
        CGFloat random = arc4random()%255;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(index*SCREEN_WIDTH, 0, SCREEN_WIDTH, 100)];
        imageView.backgroundColor = [UIColor colorWithRed:random/255 green:random/255 blue:random/255 /255 alpha:1];
        [self.scrollView3 addSubview:imageView];
    }
    [self.view addSubview:self.scrollView3];
    
    self.pageControl3 = [[MSPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.scrollView3.frame), SCREEN_WIDTH, 25)];
    self.pageControl3.numberOfPages = pageCount;//
    self.pageControl3.delegate = self;
    self.pageControl3.dotsIsSquare = YES;//是否是方形dot
    
    [self.view addSubview:self.pageControl3];
    
#pragma mark - scrollView4
    self.scrollView4 = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.pageControl3.frame), SCREEN_WIDTH, 100)];
    self.scrollView4.delegate = self;
    self.scrollView4.bounces = NO;
    self.scrollView4.pagingEnabled = YES;
    self.scrollView4.contentSize = CGSizeMake(SCREEN_WIDTH * pageCount, 100);
    for (int index = 0; index < pageCount; index++) {
        CGFloat random = arc4random()%255;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(index*SCREEN_WIDTH, 0, SCREEN_WIDTH, 100)];
        imageView.backgroundColor = [UIColor colorWithRed:random/255 green:random/255 blue:random/255 /255 alpha:1];
        [self.scrollView4 addSubview:imageView];
    }
    [self.view addSubview:self.scrollView4];
    
    self.pageControl4 = [[MSPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.scrollView4.frame), SCREEN_WIDTH, 25)];
    self.pageControl4.numberOfPages = pageCount;//
    self.pageControl4.delegate = self;
    //当前点的宽度是其他点的宽度的2倍
    //不设置pageDotSize 默认为（8，8） 即 2*width
    self.pageControl4.currentWidthMultiple = 2.5;
    self.pageControl4.pageDotSize = CGSizeMake(6, 6);
    //目前提供一种基本动画样式 如不需要可画不设置
    self.pageControl4.pageControlAnimation = MSPageControlAnimationSystem;
    [self.view addSubview:self.pageControl4];
    
#pragma mark - scrollView5
    self.scrollView5 = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.pageControl4.frame), SCREEN_WIDTH, 100)];
    self.scrollView5.delegate = self;
    self.scrollView5.bounces = NO;
    self.scrollView5.pagingEnabled = YES;
    self.scrollView5.contentSize = CGSizeMake(SCREEN_WIDTH * pageCount, 100);
    for (int index = 0; index < pageCount; index++) {
        CGFloat random = arc4random()%255;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(index*SCREEN_WIDTH, 0, SCREEN_WIDTH, 100)];
        imageView.backgroundColor = [UIColor colorWithRed:random/255 green:random/255 blue:random/255 /255 alpha:1];
        [self.scrollView5 addSubview:imageView];
    }
    [self.view addSubview:self.scrollView5];
    
    self.pageControl5 = [[MSPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.scrollView5.frame), SCREEN_WIDTH, 25)];
    self.pageControl5.numberOfPages = pageCount;//
    self.pageControl5.delegate = self;
    //设置带有数字的page样式
    self.pageControl5.pageControlStyle = MSPageControlStyleNumber;
    self.pageControl5.pageDotSize = CGSizeMake(15,15);
    self.pageControl5.spacingBetweenDots = 5;//默认是8
    self.pageControl5.dotColor = [UIColor redColor];
    self.pageControl5.currentDotColor = [UIColor blueColor];
    self.pageControl5.textColor = [UIColor whiteColor];
//    self.pageControl5.textFont = [UIFont systemFontOfSize:16];//设置字体大小
    [self.view addSubview:self.pageControl5];
    
#pragma mark - scrollView6
    self.scrollView6 = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.pageControl5.frame), SCREEN_WIDTH, 100)];
    self.scrollView6.delegate = self;
    self.scrollView6.bounces = NO;
    self.scrollView6.pagingEnabled = YES;
    self.scrollView6.contentSize = CGSizeMake(SCREEN_WIDTH * pageCount, 100);
    for (int index = 0; index < pageCount; index++) {
        CGFloat random = arc4random()%255;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(index*SCREEN_WIDTH, 0, SCREEN_WIDTH, 100)];
        imageView.backgroundColor = [UIColor colorWithRed:random/255 green:random/255 blue:random/255 /255 alpha:1];
        [self.scrollView6 addSubview:imageView];
    }
    
    [self.view addSubview:self.scrollView6];
    
    self.pageControl6 = [[MSPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.scrollView6.frame), SCREEN_WIDTH, 25)];
    self.pageControl6.numberOfPages = pageCount;//
    self.pageControl6.delegate = self;
    //设置了pagecControl图片属性 pageDotSize与currentWidthMultiple将失效
    self.pageControl6.pageDotSize = CGSizeMake(15,8);
    self.pageControl6.currentWidthMultiple = 10;
    self.pageControl6.spacingBetweenDots = 6;
    self.pageControl6.dotImage = [UIImage imageNamed:@"pageControlDot"];
    self.pageControl6.currentDotImage = [UIImage imageNamed:@"pageControlCurrentDot"];
    self.pageControl6.dotsIsSquare = YES;//设置为方形点
    [self.view addSubview:self.pageControl6];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat index = scrollView.contentOffset.x / scrollView.frame.size.width;
    CGFloat showIndex = lroundf(index);
    
    if(scrollView == self.scrollView){
        self.pageControl.currentPage = showIndex;
        return;
    }else if (scrollView == self.scrollView2){
        self.pageControl2.currentPage = showIndex;
        return;
    }else if (scrollView == self.scrollView3){
        self.pageControl3.currentPage = showIndex;
        return;
    }else if (scrollView == self.scrollView4){
        self.pageControl4.currentPage = showIndex;
        return;
    }else if (scrollView == self.scrollView5){
        self.pageControl5.currentPage = showIndex;
        return;
    }else if (scrollView == self.scrollView6){
        self.pageControl6.currentPage = showIndex;
        return;
    }
}

-(void)pageControl:(MSPageControl *)pageControl didSelectPageAtIndex:(NSInteger)index{
    NSLog(@"selectIndex = %ld",index);
    if(pageControl == self.pageControl){
        [self.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH * index, 0) animated:NO];
        return;
    }else if (pageControl == self.pageControl3){
        [self.scrollView3 setContentOffset:CGPointMake(SCREEN_WIDTH * index, 0) animated:YES];
        return;
    }else if (pageControl == self.pageControl4){
        [self.scrollView4 setContentOffset:CGPointMake(SCREEN_WIDTH * index, 0) animated:YES];
        return;
    }else if (pageControl == self.pageControl5){
        [self.scrollView5 setContentOffset:CGPointMake(SCREEN_WIDTH * index, 0) animated:YES];
        return;
    }else if (pageControl == self.pageControl6){
        [self.scrollView6 setContentOffset:CGPointMake(SCREEN_WIDTH * index, 0) animated:YES];
        return;
    }
}

@end
