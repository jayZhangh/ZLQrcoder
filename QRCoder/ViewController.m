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

@interface ViewController ()
- (IBAction)buttonOnClick:(id)sender;
- (IBAction)generatorQrcode;
@property (weak, nonatomic) IBOutlet UIImageView *qrcodeImv;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController pushViewController:[[DemoViewController alloc] init] animated:YES];
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

@end
