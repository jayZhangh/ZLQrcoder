//
//  PhotoBrowserViewController.m
//  QRCoder
//
//  Created by 瓜豆2018 on 2019/5/20.
//  Copyright © 2019年 hongyegroup. All rights reserved.
//

#import "PhotoBrowserViewController.h"
#import "ZLAssetModel.h"

@interface PhotoBrowserViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@end

@implementation PhotoBrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CellId"];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.assets count];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellId" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UICollectionViewCell alloc] init];
    }
    
    UIImageView *imv = [[UIImageView alloc] init];
    imv.translatesAutoresizingMaskIntoConstraints = NO;
    imv.contentMode = UIViewContentModeScaleToFill;
    [cell.contentView addSubview:imv];
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:imv attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:imv.superview attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0];
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:imv attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:imv.superview attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0];
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:imv attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:imv.superview attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:imv attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:imv.superview attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    [imv.superview addConstraints:@[left,right,top,bottom]];
    
    ZLAssetModel *model = self.assets[indexPath.item];
    imv.image = model.originImage;
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(20, collectionView.frame.size.height);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [UIScreen mainScreen].bounds.size;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

@end
