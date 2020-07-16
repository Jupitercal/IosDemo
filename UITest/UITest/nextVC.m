//
//  nextVC.m
//  UITest
//
//  Created by jupiter on 2020/6/8.
//  Copyright © 2020 jupiter. All rights reserved.
//

#import "nextVC.h"

@implementation nextVC
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]){
        
    }
    return self;
}
- (UILabel *)label{
    if (_label == nil){
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 200, 100, 100)];
        label.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        _label=label;
        [self.view addSubview:_label];
    }
    return _label;
}
- (void)viewDidLoad{
    [super viewDidLoad];
    UIView *myView = [[UIView alloc] init];
    myView.backgroundColor = [UIColor whiteColor];
    self.view=myView;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(20, 300, 200, 200);
    //btn.center= CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2);
    btn.backgroundColor = [UIColor blackColor];
    btn.alpha = 1.0f;
    btn.layer.cornerRadius = 5.0;
    btn.layer.borderWidth = 1.0f;
    btn.layer.borderColor = [UIColor whiteColor].CGColor;
    btn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;//垂直方向对齐方式
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//水平方向对齐方式
    
    
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    //[btn setBackgroundImage:[UIImage imageNamed:@"black"] forState:UIControlStateNormal];
    
    
    [btn addTarget:self action:@selector(btnActionJumpBack:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:btn];
}
- (void)btnActionJumpBack:(UIButton *)btn{
    [self dismissViewControllerAnimated:YES completion:^(){
        
    }];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
