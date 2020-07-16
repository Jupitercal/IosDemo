//
//  FDMyAttachment.h
//  firstDemo
//
//  Created by jupiter on 2020/6/15.
//  Copyright © 2020 jupiter. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FDMyAttachment : NSTextAttachment;
@property (nonatomic, strong) NSString *imageName;
- (NSData *)compressOriginalImage:(UIImage *)image toMaxDataSize:(CGFloat)size;
- (UIImage *)compressOriginalImage:(UIImage *)image toWidth:(CGFloat)width;
@end
NS_ASSUME_NONNULL_END
