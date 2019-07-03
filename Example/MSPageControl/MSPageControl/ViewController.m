//
//  ViewController.m
//  MSPageControl
//
//  Created by 米山 on 2019/6/27.
//  Copyright © 2019 lztbwlkj. All rights reserved.
//

#import "ViewController.h"
#import "MSPageControl.h"

@interface ViewController ()<UIScrollViewDelegate,MSPageControlDelegate>
@property (nonatomic, strong) MSPageControl *pageControl;
@end

@implementation ViewController
#define SCREEN_WIDTH     [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT    [UIScreen mainScreen].bounds.size.height


- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor lightGrayColor];
    int pageCount = 5;
    
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH, 100)];
    scrollView.delegate = self;
    scrollView.tag = 1;
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * pageCount, 130);
    for (int index = 0; index < pageCount; index++) {
        CGFloat random = arc4random()%255;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(index*SCREEN_WIDTH, 0, SCREEN_WIDTH, 130)];
        imageView.backgroundColor = [UIColor colorWithRed:random/255 green:random/255 blue:random/255 /255 alpha:1];
        [scrollView addSubview:imageView];
    }
    
//    self.pageControl = [MSPageControl pageControlSystemWithFrame:CGRectMake(0, CGRectGetMaxY(scrollView.frame), SCREEN_WIDTH, 25) numberOfPages:pageCount otherDotColor:[UIColor blueColor] currentDotColor:[UIColor redColor]];
    self.pageControl = [[MSPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(scrollView.frame), SCREEN_WIDTH, 25)];
    self.pageControl.numberOfPages = pageCount;
//    self.pageControl.currentDotColor = [UIColor yellowColor];
//    self.pageControl.dotColor = [UIColor blueColor];
    self.pageControl.pageDotSize = CGSizeMake(15, 15);
    self.pageControl.currentWidthMultiple = 2;
    self.pageControl.pageControlAnimation = MSPageControlAnimationLongChange;

//    self.pageControl.pageControlStyle = MSPageControlStyleNumber;
    self.pageControl.textColor = [UIColor redColor];
    self.pageControl.delegate = self;
////    self.pageControl.dotsIsSquare = YES;
//
    self.pageControl.dotBorderColor = [UIColor redColor];
    self.pageControl.dotBorderWidth = 1;
    self.pageControl.currentDotBorderWidth = 1;
    self.pageControl.currentDotBorderColor = [UIColor redColor];
//    self.pageControl.spacingBetweenDots = 0;
//    self.pageControl.hidesForSinglePage = YES;
//    self.pageControl.currentDotImage = [UIImage imageNamed:@"share_weixin"];
//    self.pageControl.dotImage = [UIImage imageNamed:@"share_qq"];

    [self.view addSubview:scrollView];

    [self.view addSubview:self.pageControl];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat index = scrollView.contentOffset.x / scrollView.frame.size.width;
    CGFloat showIndex = lroundf(index);
    
    self.pageControl.currentPage = showIndex;

}

-(void)pageControl:(MSPageControl *)pageControl didSelectPageAtIndex:(NSInteger)index{
    NSLog(@"selectIndex = %ld",index);
}

@end
