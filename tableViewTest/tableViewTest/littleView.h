//
//  littleView.h
//  tableViewTest
//
//  Created by jupiter on 2020/6/9.
//  Copyright © 2020 jupiter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface littleView : UIViewController
@property (nonatomic,strong) UIView *masterView;
@property (nonatomic,strong) UIButton *btn;

- (void)btnBackUp:(UIButton *)btn;
@end

NS_ASSUME_NONNULL_END
