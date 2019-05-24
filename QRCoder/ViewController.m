//
//  ViewController.m
//  QRCoder
//
//  Created by 瓜豆2018 on 2019/5/13.
//  Copyright © 2019年 hongyegroup. All rights reserved.
//

#import "ViewController.h"
#import "ScanQrcodeViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "DemoViewController.h"
#import "QrcodeGeneratorViewController.h"
#import "ZLPhotoGroupsViewController.h"
#import "RecordVideoViewController.h"
#import "MediaViewController.h"

@interface ViewController ()
- (IBAction)buttonOnClick:(id)sender;
- (IBAction)generatorQrcode;
- (IBAction)mediaOnClick;

@property (weak, nonatomic) IBOutlet UIImageView *qrcodeImv;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.navigationController pushViewController:[[DemoViewController alloc] init] animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //    [self jumpPhotosGroup];
//    [self recordingVideo];
    
}

- (void)recordingVideo {
    RecordVideoViewController *recordVideoVc = [[RecordVideoViewController alloc] init];
    [self.navigationController pushViewController:recordVideoVc animated:YES];
}

- (void)jumpPhotosGroup {
    ZLPhotoGroupsViewController *photosGroupVc = [[ZLPhotoGroupsViewController alloc] init];
    [self.navigationController pushViewController:photosGroupVc animated:YES];
}

- (IBAction)buttonOnClick:(id)sender {
    ScanQrcodeViewController *scanQrcodeVc = [[ScanQrcodeViewController alloc] init];
    [self.navigationController pushViewController:scanQrcodeVc animated:YES];
    scanQrcodeVc.qrcodeValueBlock = ^(NSString *codeString) {
        UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"message" message:codeString preferredStyle:UIAlertControllerStyleAlert];
        [alertVc addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alertVc animated:YES completion:nil];
    };
}

- (IBAction)generatorQrcode {
    QrcodeGeneratorViewController *qrcodeGeneratorVc = [[QrcodeGeneratorViewController alloc] init];
    [self.navigationController pushViewController:qrcodeGeneratorVc animated:YES];
}

- (IBAction)mediaOnClick {
    MediaViewController *mediaVc = [[MediaViewController alloc] init];
    [self.navigationController pushViewController:mediaVc animated:YES];
}

@end
