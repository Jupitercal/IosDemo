//
//  main.m
//  MRCTest
//
//  Created by jupiter on 2020/6/3.
//  Copyright © 2020 jupiter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MRCModel.h"
#import "Room.h"
#import "testAprotocol.h"
#import "testDelegate.h"
#import "catogory+testCategory.h"
#import "SELModel.h"
typedef int(^MyBlock) ( int, int);
int sql(int x){return x*x;}
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSString *str=@"the god is the girl.";
        NSString *str1=@"acd";
        NSLog(@"%@", [NSString stringWithFormat:@"%@  %@",str,str1]);
        NSMutableString *st=[[NSMutableString alloc]init];
        [st appendFormat:@"%@ %@",str1,str];
        MRCModel *Model=[[MRCModel alloc] init];
        NSMutableString *s=[NSMutableString stringWithString:@"123"];
        Model.testAssignString=s;
        NSLog(@"%p",s);
        NSLog(@"%p",Model.testAssignString);
        NSLog(@"%p",st);
        NSRange range=NSMakeRange(0, 2);
        [s appendString:@"456"];
        [s replaceCharactersInRange:range withString:@"ab"];
        NSLog(@"Next Step!");
        NSLog(@"%p %@",s,s);
        NSLog(@"%p %@",Model.testAssignString,Model.testAssignString);
        NSLog(@"%@",st);
        //for (int i = 1;i < 10; i++)NSLog(@"abc %d\n",i);
        testDelegate *test=[[testDelegate alloc] init];
        [test testDelegatePrint];
        NSLog(@"running to here");
        catogory *cate=[[catogory alloc] init];
        [cate printString];
        BOOL isBegin=[str hasPrefix:@"a"];
        if (isBegin==YES)NSLog(@"YES is 1 bit .");
        NSLog(@"%@",[str capitalizedString]);
        SELModel *sel=[[SELModel alloc] init];
        if ([sel respondsToSelector:@selector(insertModel)])NSLog(@"Yes,there is a right func.");
        if ([SELModel respondsToSelector:@selector(insertModel)])NSLog(@"Yes,there is A right func.");
        NSNumber *at=[NSNumber numberWithInt:1];
        NSMutableArray *a=[[NSMutableArray alloc] initWithObjects:@"abc", @"vd", nil];
        at=[NSNumber numberWithInt:2];
       // NSEnumerator *Eum=[a objectEnumerator];
        //-------------------------NSDictionary
        NSLog(@"%@",at);
        NSMutableDictionary *dict=[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"big", @"123", @"124", @"small", nil];
        [dict setObject:@"mid" forKey:@"3"];
        NSLog(@"dictionary is %@",[dict objectForKey:@"123"]);
        [a addObject:@"abd"];
        for (id str in a){
            NSLog(@"%@",str);
        }
        NSInteger count=a.count;
        for (int i = 0 ; i < count ;i++){
            id obj=[a objectAtIndex:i];
            NSLog(@"%@",obj);
        }
        [a sortUsingComparator:^NSComparisonResult(id obj1,id obj2){
            return [obj1 compare: obj2];
        }];
        [a addObject:@"123"];
        NSLog(@"%@",a);
        //-----------------------------Block
        MyBlock myBlock1,myBlock2;
        myBlock1=^(int a,int b){
            return a-b;
        };
        int (^plus)( int, int, int)=^(int a, int b ,int c){
            return a+b+c;
        };
        myBlock2=^(int x, int y){
            return x*y;
        };
        NSLog(@"%d",plus(2,1,3));
        NSLog(@"%d",myBlock1(23,10));
        NSLog(@"%d",myBlock2(plus(2,1,3),myBlock1(23,10)));
        [a enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
           if (idx == 2)
               *stop = YES;
            NSLog(@"%@",obj);
        }];
        [dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop){
            NSLog(@"dict %@ : %@",key,obj);
            if ([obj isEqualTo:@"2"]){
                *stop=YES;
            }
        }];
        //-------------------------------描述器排序
        NSSortDescriptor *sort1=[NSSortDescriptor sortDescriptorWithKey:@"height" ascending:NO];
        NSSortDescriptor *sort2=[NSSortDescriptor sortDescriptorWithKey:@"width"  ascending:YES];
        NSArray *sortDesc=@[sort1,sort2];
        Room *aRoom=[[Room alloc] init];
        aRoom.height=100;aRoom.width=200;
        Room *bRoom=[[Room alloc] init];
        bRoom.height=200;bRoom.width=100;
        NSArray *now=@[aRoom,bRoom];
        NSArray *sortArray=[now sortedArrayUsingDescriptors:sortDesc];
        for (Room *r in sortArray){
            NSLog(@"%d %d",r.height,r.width);
        }
        //-------------------------------NSSet
        NSLog(@"--------NNSet");
        NSSet *set=[[NSSet alloc] initWithObjects:@"123", @"345", nil];
        NSLog(@"%lu",[set count]);
        BOOL f=[set containsObject:@"123"];
        if (f){
            NSLog(@"yes");
        }
        NSIndexSet *indexSet=[[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(1, 1)];
        NSArray *setArray=[a objectsAtIndexes:indexSet];
        NSLog(@"%@",setArray);
        NSSet *set1=[[NSSet alloc] initWithObjects:@"345", nil];
        NSMutableSet *set2=[[NSMutableSet alloc] initWithObjects: @"123", @"345", nil];
        [set2 minusSet:set1];
        NSMutableIndexSet *changedIndexSet=[[NSMutableIndexSet alloc] initWithIndexesInRange:NSMakeRange(1, 1)];
        [changedIndexSet addIndex:3];
        [changedIndexSet removeIndex:3];
       // NSArray *ary=[a objectAtIndex:changedIndexSet];
        [changedIndexSet enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
            NSLog(@"%lu",idx);
        }];
        NSLog(@"IndexSet");
        NSArray *ary=[a objectsAtIndexes:changedIndexSet];
        [set2 enumerateObjectsUsingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
            if (obj==nil){
                *stop=YES;
            }
            NSLog(@"%@",obj);
        }];
        NSLog(@"---testAry Begin");
        for (id obj in ary){
            NSLog(@"%@",obj);
        }
        NSLog(@"---testAry End");
        [set2 addObject:@"12312451"];
        [set2 removeObject:@"3456"];
        [set2 unionSet:set1];
        [set2 enumerateObjectsUsingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
            if (obj==nil){
                *stop=YES;
            }
            NSLog(@"%@",obj);
        }];
        [set2 removeAllObjects];
        NSCountedSet *se=[[NSCountedSet alloc] initWithObjects:@"123", @"123", nil];
        NSLog(@"%lu",[se countForObject:@"123"]);
        //--------------block operation
        NSLog(@"任务创建：%@",[NSThread currentThread]);
        __block int number=20;
        NSBlockOperation *blockOperation=[NSBlockOperation blockOperationWithBlock:^(){
            number*=20;
        }];
        //[blockOperation start];
        NSOperationQueue *currentOperationQueue=[NSOperationQueue mainQueue];
        [currentOperationQueue setMaxConcurrentOperationCount: 2];
        [currentOperationQueue addOperation:blockOperation];
        [currentOperationQueue addOperationWithBlock:^(){
            number*=30;
            NSLog(@"number is %d",number);
        }];
      //  [blockOperation start];
        NSLog(@"%d",number);
    }
    return 0;
}
