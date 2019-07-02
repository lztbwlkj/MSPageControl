//
//  MSPageControl.m
//  MSPageControl
//
//  Created by 米山 on 2019/6/27.
//  Copyright © 2019 lztbwlkj. All rights reserved.
//

#import "MSPageControl.h"
/**
 *  Default number of pages for initialization
 */
static NSInteger const kDefaultNumberOfPages = 0;

/**
 *  Default current page for initialization
 */
static NSInteger const kDefaultCurrentPage = 0;

/**
 *  Default setting for hide for single page feature. For initialization
 */
static BOOL const kDefaultHideForSinglePage = NO;

/**
 *  Default setting for shouldResizeFromCenter. For initialiation
 */
static BOOL const kDefaultShouldResizeFromCenter = YES;

/**
 *  Default spacing between dots
 */
static NSInteger const kDefaultSpacingBetweenDots = 8;

/**
 *  Default dot size
 */
static CGSize const kDefaultDotSize = {8, 8};


static BOOL const kDefaultDotsIsSquare = NO;


@interface MSPageControl ()
/**
 *  Array of dot views for reusability and touch events.
 */
@property (strong, nonatomic) NSMutableArray *dots;
@end

@implementation MSPageControl
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    self.backgroundColor = [UIColor clearColor];
    self.spacingBetweenDots     = kDefaultSpacingBetweenDots;//默认点的间距为8
    self.numberOfPages          = kDefaultNumberOfPages;//默认点的间距为8
    self.currentPage            = kDefaultCurrentPage;//默认当前页数为第一页
    self.hidesForSinglePage     = kDefaultHideForSinglePage;//如果只有一个页面 默认是不隐藏
    self.dotColor = [UIColor colorWithWhite:1 alpha:0.5];//默认未选中点的颜色为白色，透明度50%
    self.currentDotColor = [UIColor whiteColor];//默认选中点的颜色为白色
    self.pageDotSize = kDefaultDotSize;//默认点的宽高分别为8
    self.currentWidthMultiple = 1;//当前选中点宽度与未选中点的宽度的倍数，默认为1倍
    self.dotsIsSquare = kDefaultDotsIsSquare;//默认是圆点
    self.shouldResizeFromCenter = kDefaultShouldResizeFromCenter;
    
    self.currentDotBorderWidth = 0;
    self.currentDotBorderColor = [UIColor clearColor];
    
    self.dotBorderColor = [UIColor whiteColor];
    self.dotBorderWidth = 1;
}


#pragma mark - Layout
/**
 *  Resizes and moves the receiver view so it just encloses its subviews.
 */
- (void)sizeToFit{
    [self updateFrame:YES];
}

- (void)updateFrame:(BOOL)overrideExistingFrame{
    CGPoint center = self.center;
    CGSize requiredSize = [self sizeForNumberOfPages:self.numberOfPages];
    
    // We apply requiredSize only if authorize to and necessary
    if (overrideExistingFrame || ((CGRectGetWidth(self.frame) < requiredSize.width || CGRectGetHeight(self.frame) < requiredSize.height) && !overrideExistingFrame)) {
        self.frame = CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), requiredSize.width, requiredSize.height);
        if (self.shouldResizeFromCenter) {
            self.center = center;
        }
    }
    
    [self resetDotViews];
}


#pragma mark - Setters
- (void)setNumberOfPages:(NSInteger)numberOfPages{
    _numberOfPages = numberOfPages;
    // Update dot position to fit new number of pages
    [self resetDotViews];
}


- (void)setDotImage:(UIImage *)dotImage{
    _dotImage = dotImage;
    [self resetDotViews];
}

- (void)setCurrentDotImage:(UIImage *)currentDotimage{
    _currentDotImage = currentDotimage;
    [self resetDotViews];
}

-(void)setPageDotSize:(CGSize)pageDotSize{
    _pageDotSize = pageDotSize;
    if (self.dotImage && self.currentDotImage) {
        _pageDotSize = self.dotImage.size;
    }
    [self resetDotViews];
}


-(void)setHidesForSinglePage:(BOOL)hidesForSinglePage{
    _hidesForSinglePage = hidesForSinglePage;
    if (self.dots.count == 1 && hidesForSinglePage) {
        self.hidden = YES;
    } else {
        self.hidden = NO;
    }
}

- (void)setSpacingBetweenDots:(CGFloat)spacingBetweenDots{
    
    _spacingBetweenDots = spacingBetweenDots;
    [self resetDotViews];
}


-(void)setDotColor:(UIColor *)dotColor{
    
    _dotColor = dotColor;
    [self resetDotViews];
}

-(void)setCurrentDotColor:(UIColor *)currentDotColor{
    if (self.currentDotColor == currentDotColor) return;
    
    _currentDotColor = currentDotColor;
    [self resetDotViews];
}

- (void)setCurrentPage:(NSInteger)currentPage{
    // If no pages, no current page to treat.
    if (self.numberOfPages == 0 || currentPage == _currentPage) {
        _currentPage = currentPage;
        return;
    }
    
    // Pre set
    [self changeActivity:NO atIndex:_currentPage ];
    
    _currentPage = currentPage;
    // Post set
    [self changeActivity:YES atIndex:_currentPage];
}



//
//-(void)setCurrentDotColor:(UIColor *)currentDotColor{
//    self.currentDotColor = currentDotColor;
//    [self resetDotViews];
//}


#pragma mark ================== dotView 添加 ==================
-(void)resetDotViews{
    for (UIView *dotView in self.dots) {
        [dotView removeFromSuperview];
    }
    
    [self.dots removeAllObjects];
    [self updateDots];
}

-(void)updateDots{
    if (self.numberOfPages == 0) {
        return;
    }
    
    for (NSInteger i = 0; i < self.numberOfPages; i++) {
        
        UIView *dotView;
        if (i < self.dots.count) {
            dotView = [self.dots objectAtIndex:i];
        } else {
            dotView = [self generateDotView];
        }
        [self updateDotFrame:dotView atIndex:i];
    }
    [self changeActivity:YES atIndex:self.currentPage];
    
    [self hidesForSinglePage];
}

- (UIView *)generateDotView
{
    UIView *dotView;
    
    dotView = [[UIImageView alloc] initWithImage:self.dotImage];
    dotView.backgroundColor = self.dotColor;
    dotView.frame = CGRectMake(0, 0, self.pageDotSize.width, self.pageDotSize.height);
    dotView.layer.borderColor = self.dotBorderColor.CGColor;
    dotView.layer.borderWidth = self.dotBorderWidth;
    dotView.layer.cornerRadius = self.dotsIsSquare ? 0 : self.pageDotSize.height / 2;
    if (dotView) {
        [self addSubview:dotView];
        [self.dots addObject:dotView];
    }
    
    dotView.userInteractionEnabled = YES;
    
    return dotView;
}


- (void)updateDotFrame:(UIView *)dot atIndex:(NSInteger)index{
    
    // Dots are always centered within view
    //    CGFloat width = (index == _currentPage)? self.currentPageDotSize.width:self.pageDotSize.width;
    
    CGFloat x = (self.pageDotSize.width + self.spacingBetweenDots) * index + ((CGRectGetWidth(self.frame) - [self sizeForNumberOfPages:self.numberOfPages].width ) / 2);
    
    CGFloat y = (CGRectGetHeight(self.frame) - self.pageDotSize.height) / 2;
    
    dot.frame = CGRectMake(x, y, self.pageDotSize.width, self.pageDotSize.height);
}

- (CGSize)sizeForNumberOfPages:(NSInteger)pageCount{
    return CGSizeMake((self.pageDotSize.width + self.spacingBetweenDots) * pageCount - self.spacingBetweenDots , self.pageDotSize.height);
}

#pragma mark - Touch event
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if (touch.view != self) {
        NSInteger index = [self.dots indexOfObject:touch.view];
        if ([self.delegate respondsToSelector:@selector(pageControl:didSelectPageAtIndex:)]) {
            [self.delegate pageControl:self didSelectPageAtIndex:index];
        }
    }
}


- (void)changeActivity:(BOOL)active atIndex:(NSInteger)index{
    UIImageView *dotView = (UIImageView *)[self.dots objectAtIndex:index];
    if (self.dotImage && self.currentDotImage) {
        dotView.image = (active) ? self.currentDotImage : self.dotImage;
    }
    
    if (self.dotBorderColor && self.currentDotBorderColor) {
        dotView.layer.borderColor = (active) ? self.currentDotBorderColor.CGColor : self.dotBorderColor.CGColor ;
    }
    
    if (self.dotBorderWidth && self.currentDotBorderWidth) {
        dotView.layer.borderWidth = (active) ? self.currentDotBorderWidth : self.dotBorderWidth;
    }
   
    
    if (self.dotColor || self.currentDotColor) {
        dotView.backgroundColor = (active) ? self.currentDotColor : self.dotColor;
    }
    
    if (self.currentWidthMultiple != 1) {
        CGRect oldFrame = dotView.frame;
        if (active) {
            oldFrame.origin.x -= self.pageDotSize.width * (self.currentWidthMultiple - 1);
            oldFrame.size.width = self.pageDotSize.width * self.currentWidthMultiple;
        }else{
            oldFrame.origin.x += self.pageDotSize.width * (self.currentWidthMultiple - 1);
            oldFrame.size.width = self.pageDotSize.width;
        }
        dotView.frame = oldFrame;
    }
}

- (void)createPointView {
//    for (UIView *view in self.subviews) {
//        [view removeFromSuperview];
//    }
//
//    if (self.localNumberOfPages<=0) return;
//
//
//    CGFloat startX = 0.0, startY = 0.0;
//    CGFloat mainWidth = self.localNumberOfPages * (self.localPointSize.width + self.localPointSpace);
//
//    if (self.frame.size.width > mainWidth) {
//        startX = (self.frame.size.width - mainWidth) / 2;
//    }
//
//    if (self.frame.size.height > self.localPointSize.height) {
//        startY = (self.frame.size.height - self.localPointSize.height) / 2;
//    }
//
//    for (int i = 0; i<self.localNumberOfPages; i++) {
//        if (i == self.localNumberOfPages) {
//            //当前点
//            UIView *currentPointView = [UIView new];
//            CGFloat currentPointViewWidth = self.localPointSize.width * self.localCurrentWidthMultiple;
//            currentPointView.frame = CGRectMake(startX, startY, currentPointViewWidth, self.localPointSize.height);
//            currentPointView.backgroundColor = self.localCurrentColor;
//            currentPointView.tag = i + 1000;
//            currentPointView.layer.cornerRadius = self.localIsSquare ? 0 : self.localPointSize.height / 2;
//            currentPointView.layer.masksToBounds = true;
//            currentPointView.layer.borderColor = self.localCurrentBorderColor != nil ? self.localCurrentBorderColor.CGColor : self.localCurrentColor.CGColor;
//            currentPointView.layer.borderWidth = self.localCurrentBorderWidth? self.localCurrentBorderWidth : 0;
//            currentPointView.userInteractionEnabled = YES;
//            [self addSubview: currentPointView];
//
//            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAction:)];
//            [currentPointView addGestureRecognizer:tap];
//            startX = CGRectGetMaxX(currentPointView.frame) +self.localPointSpace;
//            if (self.localCurrentImage != nil) {
//                currentPointView.backgroundColor = [UIColor clearColor];
//                UIImageView *localCurrentImageView = [UIImageView new];
//                localCurrentImageView.tag = i + 2000;
//                localCurrentImageView.frame = currentPointView.bounds;
//                localCurrentImageView.image = self.localCurrentImage;
//                [currentPointView addSubview: localCurrentImageView];
//            }
//        }else{//其他的点
//            UIView *otherPointView = [UIView new];
//            otherPointView.frame = CGRectMake(startX, startY, self.localPointSize.width, self.localPointSize.height);
//            otherPointView.backgroundColor = self.localOtherColor;
//            otherPointView.tag = i + 1000;
//            otherPointView.layer.cornerRadius = self.localIsSquare ? 0 : self.localPointSize.height / 2;
//            otherPointView.layer.borderColor = self.localOtherBorderColor != nil ? [self.localOtherBorderColor CGColor] : [self.localOtherColor CGColor];
//            otherPointView.layer.borderWidth = self.localOtherBorderWidth?self.localOtherBorderWidth : 0;
//            otherPointView.layer.masksToBounds = YES;
//            otherPointView.userInteractionEnabled = YES;
//            [self addSubview:otherPointView];
//
//            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAction:)];
//            [otherPointView addGestureRecognizer:tapGesture];
//
//            startX = CGRectGetMaxX(otherPointView.frame) + self.localPointSpace;
//
//            if (self.localOtherImage != nil) {
//                otherPointView.backgroundColor = [UIColor clearColor];
//                UIImageView *localOtherImageView = [UIImageView new];
//                localOtherImageView.tag = i + 2000;
//                localOtherImageView.frame = otherPointView.bounds;
//                localOtherImageView.image = self.localOtherImage;
//                [otherPointView addSubview:localOtherImageView];
//            }
//        }
//    }
}


#pragma mark - Getters
- (NSMutableArray *)dots
{
    if (!_dots) {
        _dots = [[NSMutableArray alloc] init];
    }
    
    return _dots;
}


@end
