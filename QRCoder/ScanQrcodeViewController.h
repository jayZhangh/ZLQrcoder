//
//  ScanQrcodeViewController.h
//  QRCoder
//
//  Created by 瓜豆2018 on 2019/5/14.
//  Copyright © 2019年 hongyegroup. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ScanQrcodeViewController : UIViewController
@property (nonatomic, copy) void (^qrcodeValueBlock)(NSString *codeString);
@end

NS_ASSUME_NONNULL_END
