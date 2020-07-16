//
//  redView.m
//  UITest
//
//  Created by jupiter on 2020/6/8.
//  Copyright © 2020 jupiter. All rights reserved.
//

#import "redView.h"

@implementation redView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self= [super initWithFrame:frame]){
        [self setBackgroundColor:[UIColor redColor]];
    }
    return self;
}
/*
- (void)drawRect:(CGRect)rect{
    self.userInteractionEnabled = NO;//它及它的子视图是否响应事件
    self.hidden = YES;
    self.alpha = 0.5;
}
 */
#pragma mark- 懒加载+子控件自动布局
- (UILabel *)label{
    if (_label==nil){
        UILabel *label=[[UILabel alloc] init];
        [label setBackgroundColor:[UIColor whiteColor]];
        label.textAlignment=NSTextAlignmentCenter;
        label.textColor=[UIColor blackColor];
        _label=label;
        [self addSubview:label];
    }
    return _label;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat personW=self.frame.size.width;
    CGFloat personH=self.frame.size.height;
    self.label.frame=CGRectMake(20, 20, personW-100, personH-100);
}

#pragma mark- 触摸事件
//触摸开始
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    //[selft nextResopnder] 该传递只响应began
}
//触摸移动中
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch=[touches anyObject];
    CGPoint current=[touch locationInView:self];
    CGPoint previous=[touch previousLocationInView:self];
    CGPoint center=self.center;
    CGPoint offset=CGPointMake(current.x-previous.x, current.y-previous.y);
    self.center=CGPointMake(center.x+offset.x, center.y+offset.y);
}
//触摸结束
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}
//触摸被打断（比如你移动的时候，有一个APP打断了你的移动事件）
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}
//当无法获得触摸的真实值时调用（触摸笔情况）
- (void)touchesEstimatedPropertiesUpdated:(NSSet<UITouch *> *)touches{
    
}
@end
