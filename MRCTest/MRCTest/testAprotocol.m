//
//  testAprotocol.m
//  MRCTest
//
//  Created by jupiter on 2020/6/3.
//  Copyright © 2020 jupiter. All rights reserved.
//

#import "testAprotocol.h"

@implementation testAprotocol
-(void) print{
    NSLog(@"you are right!");
}
-(instancetype)init{
   testDelegate *myTest=[[testDelegate alloc] init];
   myTest.delegate=self;
   // self.view=myTest;
    if (self=[super init]){
        return self;
    }else {
        return nil;
    }
}
@end
