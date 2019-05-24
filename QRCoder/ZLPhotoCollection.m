//
//  ZLPhotoCollection.m
//  QRCoder
//
//  Created by 瓜豆2018 on 2019/5/22.
//  Copyright © 2019年 hongyegroup. All rights reserved.
//

#import "ZLPhotoCollection.h"

@interface ZLPhotoCollection() <AVCaptureFileOutputRecordingDelegate>

// 负责输入和输出设备之间的连接会话
@property (nonatomic, strong) AVCaptureSession *captureSession;
// 输入源
@property (nonatomic, strong) AVCaptureDeviceInput *captureDeviceInput;
// 捕获到的视频呈现的layer
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
// 麦克风输入
@property (nonatomic, strong) AVCaptureDeviceInput *audioMicInput;
// 视频录制连接
@property (nonatomic, strong) AVCaptureConnection *videoConnection;
// 视频输出流
@property (nonatomic, strong) AVCaptureMovieFileOutput *captureMovieFileOutput;
// 设置聚焦曝光
@property (nonatomic, assign) AVCaptureFlashMode mode;
// 输入设备
@property (nonatomic, strong) AVCaptureDevice *captureDevice;
// 设置焦点
@property (nonatomic, assign) AVCaptureDevicePosition position;

@end

@implementation ZLPhotoCollection

#pragma mark - 设置相机画布
- (AVCaptureVideoPreviewLayer *)previewLayer {
    if (_previewLayer == nil) {
        _previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];
        _previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    }
    return _previewLayer;
}

#pragma mark - 创建会话
- (AVCaptureSession *)captureSession {
    if (_captureSession == nil) {
        _captureSession = [[AVCaptureSession alloc] init];
        // 画质
        _captureSession.sessionPreset = AVCaptureSessionPreset1280x720;
        
        // 连接输入与会话
        if ([_captureSession canAddInput:self.captureDeviceInput]) {
            [_captureSession addInput:self.captureDeviceInput];
        }
        
        // 连接输出与会话
        if ([_captureSession canAddOutput:self.captureMovieFileOutput]) {
            [_captureSession addOutput:self.captureMovieFileOutput];
        }
    }
    return _captureSession;
}

#pragma mark - 创建输入源
- (AVCaptureDeviceInput *)captureDeviceInput {
    if (_captureDeviceInput == nil) {
        _captureDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:self.captureDevice error:nil];
    }
    
    return _captureDeviceInput;
}

#pragma mark - 麦克风输入
- (AVCaptureDeviceInput *)audioMicInput {
    if (_audioMicInput == nil) {
        AVCaptureDevice *mic = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
        NSError *error = nil;
        _audioMicInput = [AVCaptureDeviceInput deviceInputWithDevice:mic error:&error];
        if (error) {
            NSLog(@"获取麦克风失败~%@", error);
        }
    }
    return _audioMicInput;
}

#pragma mark - 初始化设备输出对象，用于获得输出数据
- (AVCaptureMovieFileOutput *)captureMovieFileOutput {
    if (_captureMovieFileOutput == nil) {
        _captureMovieFileOutput = [[AVCaptureMovieFileOutput alloc] init];
    }
    return _captureMovieFileOutput;
}

#pragma mark - 创建输入设备
- (AVCaptureDevice *)captureDevice {
    if (_captureDevice == nil) {
        // 设置默认前置摄像头
        if (@available(iOS 10.0, *)) {
            _captureDevice = [AVCaptureDevice defaultDeviceWithDeviceType:AVCaptureDeviceTypeBuiltInWideAngleCamera mediaType:AVMediaTypeAudio position:AVCaptureDevicePositionBack];
        } else {
            
        }
        
    }
    return _captureDevice;
}

#pragma mark - 视频连接
- (AVCaptureConnection *)videoConnection {
    if (_videoConnection == nil) {
        _videoConnection = [self.captureMovieFileOutput connectionWithMediaType:AVMediaTypeVideo];
        // 是否支持稳定的视频连接
        if ([_videoConnection isVideoStabilizationSupported]) {
            _videoConnection.preferredVideoStabilizationMode = AVCaptureVideoStabilizationModeAuto;
        }
    }
    return _videoConnection;
}

#pragma mark - 获取焦点
- (AVCaptureDevicePosition)position {
    if (_position == AVCaptureDevicePositionUnspecified) {
        _position = AVCaptureDevicePositionFront;
    }
    return _position;
}

#pragma mark - 获取视频方向
- (AVCaptureVideoOrientation)getCaptureVideoOrientation {
    AVCaptureVideoOrientation result;
    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
    switch (deviceOrientation) {
        case UIDeviceOrientationPortrait:
        case UIDeviceOrientationFaceDown:
        case UIDeviceOrientationFaceUp:
            result = AVCaptureVideoOrientationPortrait;
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            // 如果这里设置成AVCaptureVideoOrientationPortraitUpsideDown，则视频方向和拍摄时的方向是相反的
            result = AVCaptureVideoOrientationPortrait;
            break;
        case UIDeviceOrientationLandscapeLeft:
            result = AVCaptureVideoOrientationLandscapeRight;
            break;
        case UIDeviceOrientationLandscapeRight:
            result = AVCaptureVideoOrientationLandscapeLeft;
            break;
        default:
            result = AVCaptureVideoOrientationPortrait;
            break;
    }
    return result;
}

#pragma mark - 视频地址
- (NSString *)getVideoPathCache {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *videoCache = [[paths firstObject] stringByAppendingPathComponent:@"videos"];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:videoCache isDirectory:&isDir];
    if (!(isDir == YES && existed == YES)) {
        [fileManager createDirectoryAtPath:videoCache withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return videoCache;
}

#pragma mark - 拼接视频文件名称
- (NSString *)getVideoNameWithType:(NSString *)fileType {
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HHmmss"];
    NSDate *nowDate = [NSDate dateWithTimeIntervalSince1970:now];
    NSString *timeStr = [formatter stringFromDate:nowDate];
    NSString *fileName = [NSString stringWithFormat:@"video_%@.%@", timeStr, fileType];
    return fileName;
}

#pragma mark - 开始录制
- (void)startCapture {
    // 如果正在录制视频就return
    if (self.captureMovieFileOutput.isRecording) {
        return;
    }
    
    NSString *defaultPath = [self getVideoPathCache];
    NSString *outputFilePath = [defaultPath stringByAppendingPathComponent:[self getVideoNameWithType:@"mp4"]];
    NSLog(@"视频保存地址：%@", outputFilePath);
    NSURL *fileUrl = [NSURL fileURLWithPath:outputFilePath];
    [self.captureMovieFileOutput startRecordingToOutputFileURL:fileUrl recordingDelegate:self];
}

#pragma mark - 停止录制
- (void)stopCapture {
    if ([self.captureMovieFileOutput isRecording]) {
        // 停止录制
        [self.captureMovieFileOutput stopRecording];
    }
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.layer insertSublayer:self.previewLayer atIndex:0];
        __weak typeof(self) wekself = self;
        // 监听屏幕方向
        [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidChangeStatusBarOrientationNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
            wekself.previewLayer.connection.videoOrientation = [self getCaptureVideoOrientation];
        }];
    }
    return self;
}

#pragma mark - 切换前后摄像头
- (void)cameraPosition:(NSString *)camera {
    if ([camera isEqualToString:@"前置"]) {
        if (self.captureDevice.position != AVCaptureDevicePositionFront) {
            self.position = AVCaptureDevicePositionFront;
        }
    } else if ([camera isEqualToString:@"后置"]) {
        if (self.captureDevice.position != AVCaptureDevicePositionBack) {
            self.position = AVCaptureDevicePositionBack;
        }
    }
    
    if (@available(iOS 10.0, *)) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithDeviceType:AVCaptureDeviceTypeBuiltInWideAngleCamera mediaType:AVMediaTypeVideo position:self.position];
        if (device) {
            self.captureDevice = device;
            AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:self.captureDevice error:nil];
            [self.captureSession beginConfiguration];
            [self.captureSession removeInput:self.captureDeviceInput];
            if ([self.captureSession canAddInput:input]) {
                [self.captureSession addInput:input];
                self.captureDeviceInput = input;
                [self.captureSession commitConfiguration];
            }
        }
    } else {
        // Fallback on earlier versions
    }
}

#pragma mark - 闪光灯开关
- (void)lightAction {
    if (self.mode == AVCaptureFlashModeOn) {
        [self setMode:AVCaptureFlashModeOff];
    } else {
        [self setMode:AVCaptureFlashModeOn];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.previewLayer.frame = self.bounds;
    [self startRunning];
}

#pragma mark - 开始运行
- (void)startRunning {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.captureSession startRunning];
    });
}

#pragma mark - 停止运行
- (void)stopRunning {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.captureSession stopRunning];
    });
}

#pragma mark - AVCaptureFileOutputRecordingDelegate
- (void)captureOutput:(AVCaptureFileOutput *)output didStartRecordingToOutputFileAtURL:(NSURL *)fileURL fromConnections:(NSArray<AVCaptureConnection *> *)connections {
    NSLog(@"开始录制");
}

- (void)captureOutput:(AVCaptureFileOutput *)output didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray<AVCaptureConnection *> *)connections error:(NSError *)error {
    NSLog(@"%@", outputFileURL);
}

@end
