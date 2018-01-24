//
//  FLJScanViewController.m
//  FLJAlertView
//
//  Created by 贾林飞 on 2018/1/24.
//  Copyright © 2018年 贾林飞. All rights reserved.
//

#import "FLJScanQRViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "UIViewController+MessageAlert.h"
#import "FLJQRScanView.h"

@interface FLJScanQRViewController ()<AVCaptureMetadataOutputObjectsDelegate>

@property(nonatomic,strong)AVCaptureSession* session;

@end

@implementation FLJScanQRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(handlerFlash)];
    
    [self creatSession];
    [self creatScanView];
}

-(void)creatScanView
{
    FLJQRScanView* maskView = [[FLJQRScanView alloc] initWithFrame:self.view.bounds];
    maskView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:maskView];
}

//创建扫描设备
-(void)creatSession
{
    AVCaptureDevice* device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    NSError* error = nil;
    AVCaptureDeviceInput* input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    if (error) {
        return;
    }
    
    AVCaptureMetadataOutput* output = [[AVCaptureMetadataOutput alloc] init];
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    //设置扫描区域的比例
    CGFloat width = 300 / CGRectGetHeight(self.view.frame);
    CGFloat height = 300 / CGRectGetWidth(self.view.frame);
    output.rectOfInterest = CGRectMake((1 - width) / 2, (1- height) / 2, width, height);
    
    AVCaptureSession* session = [[AVCaptureSession alloc] init];
    [session setSessionPreset:AVCaptureSessionPresetHigh];
    [session addInput:input];
    [session addOutput:output];
    output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,
                                   AVMetadataObjectTypeEAN13Code,
                                   AVMetadataObjectTypeEAN8Code,
                                   AVMetadataObjectTypeCode128Code];
    
    AVCaptureVideoPreviewLayer* layer = [AVCaptureVideoPreviewLayer layer];
    layer.session = session;
    layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    layer.frame = self.view.layer.frame;
    [self.view.layer insertSublayer:layer atIndex:0];
    self.session = session;
    
    [self.session startRunning];
}

-(void)handlerFlash
{
    AVCaptureDevice* device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    NSError* error;
    BOOL locked = [device lockForConfiguration:&error];
    
    //torch 是手电筒on的时候常亮   flash闪光灯，闪关灯是在拍照的时候开启的
    if ([device hasTorch]) {
        if (!error && locked) {
            if (device.torchMode == AVCaptureTorchModeOn) {
                device.torchMode = AVCaptureTorchModeOff;
                self.navigationItem.rightBarButtonItem.title = @"关闭";
            }else if (device.torchMode == AVCaptureTorchModeOff)
            {
                device.torchMode = AVCaptureTorchModeAuto;
                self.navigationItem.rightBarButtonItem.title = @"自动";
            }else
            {
                device.torchMode = AVCaptureTorchModeOn;
                self.navigationItem.rightBarButtonItem.title = @"打开";
            }
        }
    }
    
    [device unlockForConfiguration];
}

#pragma mark AVCaptureMetadataOutputObjectsDelegate
//扫描结果
-(void)captureOutput:(AVCaptureOutput *)output didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if (metadataObjects.count > 0)
    {
        [self.session stopRunning];
        
        AVMetadataMachineReadableCodeObject *metadataObject = [metadataObjects firstObject];
        NSLog(@"%@",metadataObject.stringValue);
        [self showAlertWithTitle:@"扫描结果" message:metadataObject.stringValue handler:^(UIAlertAction *action) {
            [self.session startRunning];
        }];
    }
    
}

@end
