//
//  littleView.m
//  tableViewTest
//
//  Created by jupiter on 2020/6/9.
//  Copyright © 2020 jupiter. All rights reserved.
//

#import "littleView.h"

@implementation littleView

- (UIView *)masterView{
    if (_masterView == nil){
        _masterView = [[UIView alloc] init];
        _masterView.backgroundColor = [UIColor blackColor];
    }
    return _masterView;
}
- (UIButton *)btn{
    if (_btn == nil){
        _btn = [UIButton buttonWithType:UIButtonTypeSystem];
        _btn.frame = CGRectMake(20, 20, 50, 50);
        _btn.backgroundColor = [UIColor whiteColor];
        [_btn setTitle:@"Back" forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(btnBackUp:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

- (void)btnBackUp:(UIButton *)btn{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view=self.masterView;
    [self.view addSubview:self.btn];
}
@end
