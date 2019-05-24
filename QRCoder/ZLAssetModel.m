//
//  ZLAssetModel.m
//  QRCoder
//
//  Created by 瓜豆2018 on 2019/5/20.
//  Copyright © 2019年 hongyegroup. All rights reserved.
//

#import "ZLAssetModel.h"

@implementation ZLAssetModel

- (UIImage *)thumbImage {
    return [UIImage imageWithCGImage:[self.asset aspectRatioThumbnail]];
}

- (UIImage *)originImage {
    UIImage *image = [UIImage imageWithCGImage:[[self.asset defaultRepresentation] fullScreenImage]];
    return image;
}

- (UIImage *)compressionImage {
    return [UIImage imageWithData:UIImageJPEGRepresentation(self.originImage, 0.1)];
}

- (UIImage *)fullResolutionImage {
    ALAssetRepresentation *rep = [self.asset defaultRepresentation];
    CGImageRef iref = [rep fullResolutionImage];
    return [UIImage imageWithCGImage:iref scale:[rep scale] orientation:(UIImageOrientation)[rep orientation]];
}

- (NSURL *)assetURL {
    return [[self.asset defaultRepresentation] url];
}

@end
