//
//  ZLAssetsViewController.m
//  QRCoder
//
//  Created by 瓜豆2018 on 2019/5/20.
//  Copyright © 2019年 hongyegroup. All rights reserved.
//

#import "ZLAssetsViewController.h"
#import "ZLAssetDatas.h"
#import "ZLAssetsGroupModel.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "ZLAssetModel.h"
#import "PhotoBrowserViewController.h"

@interface ZLAssetsViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *assets;

@end

@implementation ZLAssetsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.groupModel.groupName;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
    [[ZLAssetDatas shared] getAllAssetsWithGroup:self.groupModel.group callback:^(NSArray * _Nonnull results) {
        self.assets = results;
        [self.collectionView reloadData];
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.assets.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UICollectionViewCell alloc] init];
    }
    
    UIImageView *imv = [[UIImageView alloc] init];
    imv.contentMode = UIViewContentModeScaleToFill;
    imv.translatesAutoresizingMaskIntoConstraints = NO;
    [cell.contentView addSubview:imv];
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:imv attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0];
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:imv attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0];
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:imv attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:imv attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    [imv.superview addConstraints:@[left,right,top,bottom]];
    
    ZLAssetModel *assetModel = self.assets[indexPath.item];
    imv.image = assetModel.thumbImage;
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    int column = 4;
    CGFloat wh = (collectionView.frame.size.width - ((column - 1) * 4.0)) / column;
    return CGSizeMake(wh, wh);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    PhotoBrowserViewController *browser = [[PhotoBrowserViewController alloc] init];
    browser.assets = self.assets;
    [self.navigationController pushViewController:browser animated:YES];
}

@end
