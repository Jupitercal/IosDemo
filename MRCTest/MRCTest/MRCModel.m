//
//  MRCModel.m
//  MRCTest
//
//  Created by jupiter on 2020/6/3.
//  Copyright © 2020 jupiter. All rights reserved.
//

#import "MRCModel.h"

@implementation MRCModel
-(void)setR:(Room *)a{
    //[r release];
   // [a retain];
    r=a;
    NSLog(@"why not\n");
}
-(void)print{
    _a=10;
}
-(void)dealloc{
  //  [r release];
    //[super dealloc];
}
@end
