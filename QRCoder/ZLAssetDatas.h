//
//  ZLAssetDatas.h
//  QRCoder
//
//  Created by 瓜豆2018 on 2019/5/20.
//  Copyright © 2019年 hongyegroup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZLAssetDatas : NSObject
+ (instancetype)shared;
- (void)getAllAssetsGroup:(void (^)(NSArray *groups))callback;
- (void)getAllAssetsWithGroup:(ALAssetsGroup *)group callback:(void (^)(NSArray *results))callback;
@end

NS_ASSUME_NONNULL_END
