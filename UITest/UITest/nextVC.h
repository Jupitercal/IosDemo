//
//  nextVC.h
//  UITest
//
//  Created by jupiter on 2020/6/8.
//  Copyright © 2020 jupiter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface nextVC : UIViewController;
@property (nonatomic,strong) UILabel *label;
- (void)btnActionJumpBack:(UIButton *)btn;
@end

NS_ASSUME_NONNULL_END
