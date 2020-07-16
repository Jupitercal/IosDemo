//
//  ViewController.h
//  ScrollViewTest
//
//  Created by jupiter on 2020/6/8.
//  Copyright © 2020 jupiter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    NSTimer *timer;
}
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIPageControl *pageControl;

- (void)changeImage:(NSTimer *)timer;
- (void)updateContentOffsetAndCurrentPage;
@end

