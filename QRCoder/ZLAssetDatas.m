//
//  ZLAssetDatas.m
//  QRCoder
//
//  Created by 瓜豆2018 on 2019/5/20.
//  Copyright © 2019年 hongyegroup. All rights reserved.
//

#import "ZLAssetDatas.h"
#import "ZLAssetsGroupModel.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "ZLAssetModel.h"

@interface ZLAssetDatas ()
@property (nonatomic, strong) ALAssetsLibrary *library;
@end

@implementation ZLAssetDatas

+ (ALAssetsLibrary *)defaultAssetsLibrary {
    static dispatch_once_t onceToken = 0;
    static ALAssetsLibrary *library = nil;
    dispatch_once(&onceToken, ^{
        library = [[ALAssetsLibrary alloc] init];
    });
    
    return library;
}

- (ALAssetsLibrary *)library {
    if (_library == nil) {
        _library = [self.class defaultAssetsLibrary];
    }
    return _library;
}

+ (instancetype)shared {
    return [[self alloc] init];
}

- (void)getAllAssetsGroup:(void (^)(NSArray *groups))callback {
    NSMutableArray *groups = [NSMutableArray array];
    [self.library enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if (group) {
            [group setAssetsFilter:[ALAssetsFilter allPhotos]];
            ZLAssetsGroupModel *groupModel = [[ZLAssetsGroupModel alloc] init];
            groupModel.group = group;
            groupModel.groupName = [group valueForProperty:@"ALAssetsGroupPropertyName"];
            groupModel.thumbImage = [UIImage imageWithCGImage:[group posterImage]];
            groupModel.assetsCount = [group numberOfAssets];
            [groups addObject:groupModel];
        } else {
            callback(groups);
        }
        
    } failureBlock:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (void)getAllAssetsWithGroup:(ALAssetsGroup *)group callback:(void (^)(NSArray *results))callback {
    NSMutableArray *assets = [NSMutableArray array];
    [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
        if (result) {
            ZLAssetModel *assetModel = [[ZLAssetModel alloc] init];
            assetModel.asset = result;
            [assets addObject:assetModel];
        } else {
            callback(assets);
        }
    }];
}

@end
