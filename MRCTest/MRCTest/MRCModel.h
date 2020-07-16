//
//  MRCModel.h
//  MRCTest
//
//  Created by jupiter on 2020/6/3.
//  Copyright © 2020 jupiter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Room.h"

@interface MRCModel:NSObject{
    Room *r;
}
@property int a;
@property NSMutableString *testAssignString;
-(void)setR:(Room *)a;
-(void)dealloc;
-(void)print;
@end
