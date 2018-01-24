//
//  FLJRecognizeViewController.m
//  FLJAlertView
//
//  Created by 贾林飞 on 2018/1/24.
//  Copyright © 2018年 贾林飞. All rights reserved.
//

#import "FLJRecognizeQRViewController.h"
#import "UIViewController+MessageAlert.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface FLJRecognizeQRViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property(nonatomic,strong)UIImageView* imageView;

@end

@implementation FLJRecognizeQRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"长按图片识别二维码";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"相册" style:UIBarButtonItemStylePlain target:self action:@selector(openPhotoLibrary)];
    [self setupSubViews];
}

#pragma mark 选择相册 UIImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSString* type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:(NSString*)kUTTypeImage]) {
        self.imageView.image = [info objectForKey:UIImagePickerControllerOriginalImage];
        [self dismissViewControllerAnimated:YES completion:^{
            [self recognizeQRCodeFromImage:self.imageView.image];
        }];
    }
}

#pragma mark private

#pragma mark 识别图片二维码
- (void)recognizeQRCodeFromImage:(UIImage *)image
{
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode
                                              context:nil
                                              options:@{CIDetectorAccuracy:CIDetectorAccuracyHigh}];
    
    NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
    if (features.count >= 1)
    {
        CIQRCodeFeature *feature = [features firstObject];
        
        [self showAlertWithTitle:@"扫描结果" message:feature.messageString handler:nil];
    }
    else
    {
        [self showAlertWithTitle:@"提示" message:@"图片里没有二维码" handler:nil];
    }
}

#pragma mark 长按事件
-(void)longPressGesture:(UILongPressGestureRecognizer*)gesture
{
    if (gesture && gesture.state == UIGestureRecognizerStateBegan) {
        [self recognizeQRCodeFromImage:self.imageView.image];
    }
}

-(void)openPhotoLibrary
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController* picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.delegate = self;

        [self presentViewController:picker animated:YES completion:nil];
    }else
    {
        [self showAlertWithTitle:@"提示" message:@"无法打开相册" handler:nil];
    }
}

-(void)setupSubViews
{
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, self.view.bounds.size.width-20, self.view.bounds.size.width-20)];
    self.imageView.center = self.view.center;
    self.imageView.userInteractionEnabled = YES;
    UILongPressGestureRecognizer* gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGesture:)];
    [self.imageView addGestureRecognizer:gesture];
    
    [self.view addSubview:self.imageView];
}


@end
