//
//  ZLAssetsGroupModel.h
//  QRCoder
//
//  Created by 瓜豆2018 on 2019/5/20.
//  Copyright © 2019年 hongyegroup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZLAssetsGroupModel : NSObject
@property (nonatomic, copy) NSString *groupName;
@property (nonatomic, strong) UIImage *thumbImage;
@property (nonatomic, assign) NSInteger assetsCount;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, strong) ALAssetsGroup *group;
@end

NS_ASSUME_NONNULL_END
