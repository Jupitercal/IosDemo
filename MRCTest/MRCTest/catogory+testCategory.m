//
//  catogory+testCategory.m
//  MRCTest
//
//  Created by jupiter on 2020/6/4.
//  Copyright © 2020 jupiter. All rights reserved.
//

#import "catogory+testCategory.h"

@implementation catogory (testCategory)
-(void)printString{
    NSMutableString *s=[NSMutableString stringWithString:@"abc"];
    NSLog(@"%@",s);
    NSLog(@"%d",[self solveToX:20 ToY:30]);
    [self changeString:s];
    NSLog(@"%@",s);
}
@end
