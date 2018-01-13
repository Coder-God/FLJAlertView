//
//  FLJViewController.m
//  FLJAlertView
//
//  Created by 贾林飞 on 2018/1/9.
//  Copyright © 2018年 贾林飞. All rights reserved.
//

#import "FLJModalViewController.h"
#import "FLJModalTransitionAnimation.h"
#import <Masonry.h>

@interface FLJModalViewController ()<UIViewControllerTransitioningDelegate>


@end

@implementation FLJModalViewController

+(instancetype)creatAlertVC
{
    FLJModalViewController* VC = [[FLJModalViewController alloc] init];
    VC.transitioningDelegate = VC;
    VC.modalPresentationStyle = UIModalPresentationCustom;
    return VC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    self.bgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.bgView.backgroundColor = [UIColor blackColor];
    self.bgView.alpha = 0.0f;
    
    __weak typeof(self) weakSelf = self;
    self.alertView = [[FLJInputAlertView alloc] init];
    self.alertView.cancelBlock = ^{
        [weakSelf dismissViewController];
    };
    
    self.alertView.completionBlock = ^{
        [weakSelf dismissViewController];
    };
    
    [self.view addSubview:self.bgView];
    [self.view addSubview:self.alertView];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    //由于键盘弹出后，在输入时会更新frame，latestFrame保存键盘弹出后的frame
    if (self.alertView.inputField.isFirstResponder) {
        self.alertView.frame = self.alertView.latestFrame;
    }else
    {
        [self.alertView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(260);
            make.centerX.equalTo(self.view.mas_centerX);
            make.centerY.equalTo(self.view.mas_centerY);
        }];
    }
}

-(void)dismissViewController
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [[FLJModalTransitionAnimation alloc] init];
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [[FLJModalTransitionAnimation alloc] init];
}

@end
