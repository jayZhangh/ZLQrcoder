//
//  ZLPhotoCollection.h
//  QRCoder
//
//  Created by 瓜豆2018 on 2019/5/22.
//  Copyright © 2019年 hongyegroup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZLPhotoCollection : UIView

// 闪光灯开关
- (void)lightAction;
// 停止运行
- (void)stopRunning;
// 开始运行
- (void)startRunning;
// 开始录制
- (void)startCapture;
// 停止录制
- (void)stopCapture;
/**
 切换前后摄像头
 #param camera 前置、后置
 */
- (void)cameraPosition:(NSString *)camera;

@end

NS_ASSUME_NONNULL_END
