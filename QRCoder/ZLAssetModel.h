//
//  ZLAssetModel.h
//  QRCoder
//
//  Created by 瓜豆2018 on 2019/5/20.
//  Copyright © 2019年 hongyegroup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZLAssetModel : NSObject
@property (nonatomic, strong) ALAsset *asset;
// 缩略图
@property (nonatomic, strong) UIImage *thumbImage;
// 压缩原图
@property (nonatomic, strong) UIImage *compressionImage;
// 原图
@property (nonatomic, strong) UIImage *originImage;
// 全屏图
@property (nonatomic, strong) UIImage *fullResolutionImage;
// 获取相册的URL
@property (nonatomic, strong) NSURL *assetURL;
@end

NS_ASSUME_NONNULL_END
