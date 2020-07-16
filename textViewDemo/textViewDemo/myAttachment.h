//
//  myAttachment.h
//  textViewDemo
//
//  Created by jupiter on 2020/6/15.
//  Copyright © 2020 jupiter. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface myAttachment : NSTextAttachment;
@property (nonatomic, strong) NSString *imageName;
@property (nonatomic) CGFloat imageSizeWidth;
- (CGRect)resizeImageForImageWidth:(CGFloat)imageWidth;
@end

NS_ASSUME_NONNULL_END
