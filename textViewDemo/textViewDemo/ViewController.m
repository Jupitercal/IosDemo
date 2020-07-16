//
//  ViewController.m
//  textViewDemo
//
//  Created by jupiter on 2020/6/12.
//  Copyright © 2020 jupiter. All rights reserved.
//

#import "ViewController.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
@interface ViewController ()

@end

@implementation ViewController
#pragma mark - lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   // self.view.translatesAutoresizingMaskIntoConstraints = YES;
 //   NSLog(@"niuniuniu");
    UIBarButtonItem *album = [[UIBarButtonItem alloc] initWithTitle:@"album" style:UIBarButtonItemStyleDone target:self action:@selector(btnJumpToAlbum:)];
    self.toolbarItems = @[album];
    self.view = self.textView;
    
    [self.navigationController setToolbarHidden:NO];
    
}
- (void)viewWillLayoutSubviews{
    NSAttributedString *textAttribution = self.textView.attributedText;
   // NSLog(@"and textString will display");
    NSString *string = textAttribution.textString;
    NSString *zhengze = @"\\{\\[.*?\\]\\}";
    NSRegularExpression *re = [NSRegularExpression regularExpressionWithPattern:zhengze options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray *arr = [re matchesInString:string options:0 range:NSMakeRange(0, string.length)];
    for (NSInteger j=arr.count - 1; j >= 0; j--){
        NSTextCheckingResult *result = arr[j];
        NSLog(@"匹配结果有：%@",[string substringWithRange:result.range]);
    }
}
#pragma mark - lazyload
- (UIImageView *)imageView{
    if (_imageView == nil){
        UIImage *image = [self loadImage:@"B84E8479-475C-4727-A4A4-B77AA9980897.jpg"];
        if (image == nil){
            NSLog(@"WRONG");
        }else NSLog(@"image is here");
        _imageView = [[UIImageView alloc] init];
        _imageView.image = image;
    }
    return _imageView;
}
- (UITextView *)textView{
    if (_textView == nil){
        _textView = [[UITextView alloc] init];
        
       // _textView.translatesAutoresizingMaskIntoConstraints = NO;
       // [_textView mas_makeConstraints:^(MASContr)]
        _textView.font = [UIFont systemFontOfSize:20];
        _textView.keyboardType = UIKeyboardTypeDefault;
        _textView.returnKeyType = UIReturnKeyDefault;
        _textView.delegate = self;
       // _textView.inputAccessoryView = self.keyBoardToolBar;
    }
    return _textView;
}
- (UIImagePickerController *)imagePickController{
    if (_imagePickController == nil){
        _imagePickController = [[UIImagePickerController alloc] init];
        _imagePickController.delegate = self;
    }
    return _imagePickController;
}
#pragma mark - UITextView Delegate
- (void)textViewDidBeginEditing:(UITextView *)textView{
  //  [textView becomeFirstResponder];
}
- (bool)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    self.textView.font = [UIFont systemFontOfSize:20];
    return YES;
}
#pragma mark - ImagePickerController Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
  //  NSLog(@"选图完毕");
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    NSMutableString *imageName = [NSMutableString new];
    if (picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary){
        NSMutableString *src = [[NSString stringWithFormat:@"%@",(NSString *)[info objectForKey:@"UIImagePickerControllerReferenceURL"]] mutableCopy];
        BOOL Copy = FALSE;
        for (NSInteger i = 0; i < src.length; i++){
            unichar c = [src characterAtIndex:i];
            if (c == '&'){
                break;
            }
            if (c == '='){
                Copy = TRUE;
                continue;
            }
            if (Copy){
                [imageName appendFormat:@"%c",c];
            }
        }
     //   NSLog(@"%@",src);
        [imageName appendString:@".jpg"];
    }
    //NSLog(@"%@", imageName);
    [self saveImage:image Name:imageName];
    [self insertImage:image name:imageName];
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - Button Operation
- (void)btnJumpToAlbum:(UIBarButtonItem *)keyBoardToolBar{
    [self.imagePickController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:self.imagePickController animated:YES completion:nil];
    
    //NSLog(@"niu miu ㍿");
}
#pragma mark - Void List
- (void)insertImage:(UIImage *)image name:(NSString *)name{
    myAttachment *myAttach = [[myAttachment alloc] init];
    myAttach.image = image;
    myAttach.imageName = name;
    myAttach.imageSizeWidth = 150;
//    [self.textView.text stringByAppendingString:@"牛牛牛牛牛牛牛牛牛牛牛牛牛牛牛牛牛"];
    [self.textView.textStorage insertAttributedString:[NSAttributedString attributedStringWithAttachment:myAttach] atIndex:self.textView.selectedRange.location];
    
}
- (void)saveImage:(UIImage *)image Name:(NSString *)name{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:name];
    NSData *imageData = UIImageJPEGRepresentation(image, 0.1);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:filePath]){
        BOOL result = [imageData writeToFile:filePath atomically:YES];
        if (result == NO){
            NSLog(@"save failed!");
        }
    }else{
        NSLog(@"the image exists");
    }
}
- (UIImage *)loadImage:(NSString *)name{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:name];
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    return image;
}
@end
