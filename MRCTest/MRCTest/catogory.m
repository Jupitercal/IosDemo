//
//  catogory.m
//  MRCTest
//
//  Created by jupiter on 2020/6/4.
//  Copyright © 2020 jupiter. All rights reserved.
//

#import "catogory.h"

@implementation catogory
-(int)solveToX:(int)x ToY:(int)y{
    return x+y;
}
-(void)changeString:(NSMutableString *)str{
    @autoreleasepool {
        NSMutableString *s=[str mutableCopy];
        [str appendString:@"yes"];
        NSLog(@"amazing %@",s);
        [s appendString:@"no"];
    }
}
@end
