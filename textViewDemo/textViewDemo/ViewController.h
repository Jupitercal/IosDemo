//
//  ViewController.h
//  textViewDemo
//
//  Created by jupiter on 2020/6/12.
//  Copyright © 2020 jupiter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
#import "myAttachment.h"
#import "NSAttributedString+imageExtension.h"
@interface ViewController : UIViewController <UITextViewDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIImagePickerController *imagePickController;
@property (nonatomic, strong) UIImageView *imageView;
- (void)btnJumpToAlbum:(UIBarButtonItem *)keyBoardToolBar;
- (void)saveImage:(UIImage *)image Name:(NSString *)name;
- (UIImage *)loadImage:(NSString *)name;
- (void)insertImage:(UIImage *)image name:(NSString *)name;
@end

