//
//  SystemShredFunctionViewController.m
//  QRCoder
//
//  Created by 瓜豆2018 on 2019/5/22.
//  Copyright © 2019年 hongyegroup. All rights reserved.
//

#import "SystemShredFunctionViewController.h"

@interface SystemShredFunctionViewController ()

@end

@implementation SystemShredFunctionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
/*
 
 //UIActivityTypePostToFacebook,
 //UIActivityTypePostToTwitter,
 //UIActivityTypePostToWeibo,
 //UIActivityTypeMessage,
 //UIActivityTypeMail,
 //UIActivityTypePrint,
 //UIActivityTypeCopyToPasteboard,
 //UIActivityTypeAssignToContact,
 //UIActivityTypeSaveToCameraRoll,
 //UIActivityTypeAddToReadingList,
 //UIActivityTypePostToFlickr,
 //UIActivityTypePostToVimeo,
 //UIActivityTypePostToTencentWeibo,
 //UIActivityTypeAirDrop,
 //UIActivityTypeOpenInIBooks
 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSString *textToShare = @"我是ZL，欢迎关注我！";
    UIImage *imageToShare = [UIImage imageNamed:@"xingxing_change"];
    NSURL *urlToShare = [NSURL URLWithString:@"https://github.com/"];
    NSArray *activityItems = @[textToShare,urlToShare,imageToShare];
    UIActivityViewController *vc = [[UIActivityViewController alloc] initWithActivityItems:activityItems
                                                                     applicationActivities:@[]];
    //    vc.excludedActivityTypes = @[UIActivityTypePostToVimeo];
    
    vc.completionWithItemsHandler = ^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
        NSLog(@"%@", activityType);
        if (completed) {
            NSLog(@"completed");
        } else {
            NSLog(@"cancel");
        }
    };
    [self presentViewController:vc animated:YES completion:nil];
}




@end
