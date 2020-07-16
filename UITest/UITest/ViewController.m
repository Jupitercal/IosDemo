//
//  ViewController.m
//  UITest
//
//  Created by jupiter on 2020/6/5.
//  Copyright © 2020 jupiter. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]){
        return self;
    }
    return nil;
}
/*
- (UILabel *)myLabel{
    if (_myLabel==nil){
        UILabel *myLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, 500, 200, 50)];
        myLabel.backgroundColor=[[UIColor whiteColor] colorWithAlphaComponent:0];
        myLabel.textColor=[UIColor blackColor];
        myLabel.textAlignment=NSTextAlignmentCenter;
        _myLabel=myLabel;
        [self.view addSubview:_myLabel];
    }
    return _myLabel;
}
 */
- (UITextField *)textField{
    if (_textField == nil){
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(20, 300, 150, 100)];
        textField.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
        textField.textColor = [UIColor blackColor];
        _textField=textField;
        [self.view addSubview:_textField];
    }
    return _textField;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    @autoreleasepool {
        UIView *masterView = [[UIView alloc] init];
        if ([UIView isSubclassOfClass:[UIResponder class]]){
            NSLog(@"Yes,it's right.");
        }
        masterView.backgroundColor = [UIColor whiteColor];
        //UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:masterView];
       // [masterView release];
        redView *myRedView = [[redView alloc] initWithFrame:CGRectMake(20, 20, 300, 300)];
        myRedView.label.text = @"Hello I'm subview.";
        [masterView addSubview:myRedView];
        self.view = masterView;
        self.textField.placeholder = @"要传递的字符串";
        /*
        //--------------UIImageView
        UIImage *image=[UIImage imageNamed:@"timg.jpeg"];
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(100,100,200,200)];
        imageView.image=image;
        NSLog(@"%@",image);
        imageView.contentMode=UIViewContentModeScaleAspectFit;
        imageView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:imageView];
        //--------------UILabel
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(100, 300, 300, 200)];
        label.font=[UIFont systemFontOfSize:20];
        NSString *str=@"123";
        label.text=str;
        //label.frame=CGRectMake(50, 100, 200, 200);
        NSLog(@"%@",label.text);
        [self.view addSubview:label];*/
        //-------------UIButton
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn.frame = CGRectMake(200, 330, 50, 50);
        //btn.center= CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2);
        btn.backgroundColor = [UIColor whiteColor];
        btn.alpha = 1.0f;
        btn.layer.cornerRadius = 5.0;
        btn.layer.borderWidth = 1.0f;
        btn.layer.borderColor = [UIColor whiteColor].CGColor;
        btn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;//垂直方向对齐方式
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//水平方向对齐方式
        
        
        [btn setTitle:@"跳转" forState:UIControlStateNormal];
        //[btn setBackgroundImage:[UIImage imageNamed:@"black"] forState:UIControlStateNormal];
        
        
        [btn addTarget:self action:@selector(btnActionJump:) forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:btn];
        //----------UITextField
    }
}
- (void)viewWillAppear:(BOOL)animated{
    NSLog(@"viewWillAsppear");
}
- (void)viewWillLayoutSubviews{
    NSLog(@"viewWillLayoutSubviews");
}
- (void)viewDidLayoutSubviews{
    NSLog(@"viewDidLayoutSubviews");
}
- (void)viewDidAppear:(BOOL)animated{
    NSLog(@"viewDidAppear");
}
- (void)viewWillDisappear:(BOOL)animated{
    NSLog(@"viewWillDisappear");
}
- (void)viewDidDisappear:(BOOL)animated{
    NSLog(@"viewDidDisappear");
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    long colorNumber=random();
    UIColor *color=[UIColor whiteColor];
    if (colorNumber%2)color=[UIColor blackColor];
    [self.view setBackgroundColor:color];
}

#pragma mark - 按钮响应
- (void)btnActionJump:(UIButton *)btn{
    nextVC *next = [[nextVC alloc] init];
    next.modalTransitionStyle = 0;
    //self.myLabel.text=@"This button works well.";
    next.label.text=_textField.text;
    //-----模态跳转
    [self presentViewController:next animated:YES completion:^(){
        
    }];
    
    //[self showViewController:next sender:btn];
     
   // [self.navigationController pushViewController:next animated:YES];
}
@end
