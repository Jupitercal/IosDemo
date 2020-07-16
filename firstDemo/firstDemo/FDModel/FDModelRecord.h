//
//  record.h
//  firstDemo
//
//  Created by jupiter on 2020/6/10.
//  Copyright © 2020 jupiter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FDMyAttachment.h"
NS_ASSUME_NONNULL_BEGIN

@interface record : NSObject
@property int ID;
@property int groupID;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *item;
@property (nonatomic, strong) NSDateFormatter *dateFormat;
@property (nonatomic, strong) NSString *createTime;
- (void)setRecordData:(int)Id AndDate:(NSDate *)date AndItem:(NSString *)item AndGroupID:(int)groupID;
- (NSAttributedString *)stringTransferAttributedString;
- (UIImage *)loadImage:(NSString *)name;
- (NSString *)presentItem;
@end

NS_ASSUME_NONNULL_END
