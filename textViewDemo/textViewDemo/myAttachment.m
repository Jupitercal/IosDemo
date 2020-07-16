//
//  myAttachment.m
//  textViewDemo
//
//  Created by jupiter on 2020/6/15.
//  Copyright © 2020 jupiter. All rights reserved.
//

#import "myAttachment.h"

@implementation myAttachment

- (CGRect)attachmentBoundsForTextContainer:(NSTextContainer *)textContainer proposedLineFragment:(CGRect)lineFrag glyphPosition:(CGPoint)position characterIndex:(NSUInteger)charIndex{
    return [self resizeImageForImageWidth:_imageSizeWidth];
}
- (CGRect)resizeImageForImageWidth:(CGFloat)imageWidth{
    CGFloat factor;
    CGSize orginSize = [self.image size];
    factor = imageWidth / orginSize.width;
    CGRect newSize = CGRectMake(0, 0, orginSize.width * factor, orginSize.height * factor);
    return newSize;
}
@end
