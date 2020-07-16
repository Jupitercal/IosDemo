//
//  ViewController.m
//  ScrollViewTest
//
//  Created by jupiter on 2020/6/8.
//  Copyright © 2020 jupiter. All rights reserved.
//

#define SC_HEIGHT [UIScreen mainScreen].bounds.size.height/3
#define SC_WIDTH  [UIScreen mainScreen].bounds.size.width
#import "ViewController.h"

@interface ViewController () <UIScrollViewDelegate>

@end

@implementation ViewController

#pragma mark - 懒加载
- (UIScrollView *)scrollView{
    if (_scrollView == nil){
        UIScrollView *sc = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 20, SC_WIDTH, SC_HEIGHT)];
        sc.contentSize = CGSizeMake(SC_WIDTH * 5, SC_HEIGHT);
        sc.pagingEnabled = YES;
        sc.showsHorizontalScrollIndicator = NO;
        sc.bounces = NO;
        sc.contentOffset = CGPointMake(SC_WIDTH, 0);
        _scrollView = sc;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (UIPageControl *)pageControl{
    if (_pageControl == nil){
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.frame = CGRectMake(0, SC_HEIGHT-10, SC_WIDTH, 30);
        _pageControl.numberOfPages = 3;
        _pageControl.backgroundColor = [UIColor clearColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    }
    return _pageControl;
}

#pragma mark - lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    for (int i = 0; i < 5; i++){
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(i * SC_WIDTH, 0, SC_WIDTH, SC_HEIGHT);
        if (i == 0){
            imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"3.jpeg"]];
        }else if (i == 4){
            imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"1.jpeg"]];
        }else{
            imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpeg", i ]];
        }
        [self.scrollView addSubview:imageView];
    }
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.pageControl];
    timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(changeImage:) userInfo:nil repeats:YES];
}

#pragma mark - scrollview delegate
//拉动图片结束
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    timer.fireDate = [NSDate dateWithTimeInterval:3.0 sinceDate:[NSDate date]];
    [self updateContentOffsetAndCurrentPage];
}
//开始拉动图片
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [timer setFireDate:[NSDate distantFuture]];
}

#pragma mark -
- (void)changeImage:(NSTimer *)timer{
    CGPoint tempPoint = self.scrollView.contentOffset;
    tempPoint.x += SC_WIDTH;
    /*
    if (tempPoint.x / SC_WIDTH >= 4){
        tempPoint.x = 1 * SC_WIDTH;
    }
     */
    self.scrollView.contentOffset = tempPoint;
    [self updateContentOffsetAndCurrentPage];
}

- (void)updateContentOffsetAndCurrentPage{
    CGPoint now = self.scrollView.contentOffset;
    if (now.x >= 4*SC_WIDTH){
        now.x = 1*SC_WIDTH;
    }else if (now.x <= 0){
        now.x = SC_WIDTH * 3;
    }
    self.scrollView.contentOffset = now;
    
    NSInteger currentPage = (self.scrollView.contentOffset.x - SC_WIDTH) / SC_WIDTH;
    self.pageControl.currentPage = currentPage;
}
@end
