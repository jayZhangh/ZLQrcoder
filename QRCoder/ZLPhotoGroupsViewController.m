//
//  ZLPhotoGroupsViewController.m
//  QRCoder
//
//  Created by 瓜豆2018 on 2019/5/20.
//  Copyright © 2019年 hongyegroup. All rights reserved.
//

#import "ZLPhotoGroupsViewController.h"
#import "ZLAssetDatas.h"
#import "ZLAssetsGroupModel.h"
#import "ZLAssetsViewController.h"

@interface ZLPhotoGroupsViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *groups;
@end

@implementation ZLPhotoGroupsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ALAuthorizationStatus *auth = [ALAssetsLibrary authorizationStatus];
    if (auth == ALAuthorizationStatusRestricted || auth == ALAuthorizationStatusDenied) {
        NSLog(@"没有获取相册权限");
        
    } else {
        [[ZLAssetDatas shared] getAllAssetsGroup:^(NSArray * _Nonnull groups) {
            self.groups = groups;
            [self.tableView reloadData];
        }];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.groups.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellId"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    ZLAssetsGroupModel *group = self.groups[indexPath.row];
    cell.imageView.image = group.thumbImage;
    cell.textLabel.text = group.groupName;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld", (long)[group assetsCount]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ZLAssetsViewController *assetsVc = [[ZLAssetsViewController alloc] init];
    assetsVc.groupModel = self.groups[indexPath.row];
    [self.navigationController pushViewController:assetsVc animated:YES];
}

@end
