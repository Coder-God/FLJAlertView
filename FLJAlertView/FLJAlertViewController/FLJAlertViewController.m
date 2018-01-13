//
//  FLJAlertViewController.m
//  FLJAlertView
//
//  Created by 贾林飞 on 2018/1/12.
//  Copyright © 2018年 贾林飞. All rights reserved.
//

#import "FLJAlertViewController.h"
#import "FLJAlertTransionAnimation.h"
#import <Masonry.h>

@interface FLJAlertViewController ()<UIViewControllerTransitioningDelegate>

@property(nonatomic,strong)UIView* bgView;

@property(nonatomic,strong)UIView* contentView;

@property(nonatomic,strong)UILabel* titleLabel;

@property(nonatomic,strong)UILabel* detailLabel;

@property(nonatomic,strong)UIView* hLine;

@property(nonatomic,strong)UIView* vLine;

@property(nonatomic,strong)UIButton* leftBtn;

@property(nonatomic,strong)UIButton* rightBtn;

@property(nonatomic,copy)NSString* titleString;

@property(nonatomic,copy)NSString* describe;

@end

@implementation FLJAlertViewController

+(instancetype)alertViewController
{
    FLJAlertViewController* alertVC = [[FLJAlertViewController alloc] init];
    alertVC.transitioningDelegate = alertVC;
    alertVC.modalPresentationStyle = UIModalPresentationCustom;
    return alertVC;
}

+(instancetype)alertViewControllerWithTitle:(NSString *)title description:(NSString *)description
{
    NSAssert(title.length > 0 || description.length > 0 , @"title和description不能同时为空");

    FLJAlertViewController* alertVC = [self alertViewController];
    alertVC.titleString = title;
    alertVC.describe = description;
    return alertVC;
}

-(void)executeAlertShowAnimationWithDuration:(CGFloat)duration completionBlock:(void (^)(void))completionBlock
{
    self.contentView.alpha = .0f;
    self.contentView.transform = CGAffineTransformMakeScale(.3f, .3f);
    [UIView animateWithDuration:duration animations:^{
        self.contentView.alpha = 1.f;
        self.contentView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        if (completionBlock) {
            completionBlock();
        }
    }];
}

-(void)executeAlertHideAnimationWithDuration:(CGFloat)duration completionBlock:(void(^)(void))completionBlock
{
    [UIView animateKeyframesWithDuration:duration delay:.0f options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        self.contentView.alpha = .0f;
        self.bgView.alpha = .0f;
    } completion:^(BOOL finished) {
        if (completionBlock) {
            completionBlock();
        }
    }];
}

-(void)setTitleString:(NSString *)titleString
{
    _titleString = titleString;
    self.titleLabel.text = _titleString;
}

-(void)setDescribe:(NSString *)describe
{
    _describe = describe;
    self.detailLabel.text = _describe;
}

-(void)leftBtnDidClicked
{
    if (self.leftBtnAction) {
        self.leftBtnAction();
    }else{
        [self dismissViewController];
    }
}

-(void)rightBtnDidClicked
{
    if (self.rightBtnAction) {
        self.rightBtnAction();
    }else{
        [self dismissViewController];
    }
}

-(void)dismissViewController
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [FLJAlertTransionAnimation new];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [FLJAlertTransionAnimation new];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubViews];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    if (self.titleString == nil || [self.titleString isEqualToString:@""]) {
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(0);
            make.left.equalTo(self.contentView.mas_left).offset(15);
            make.right.equalTo(self.contentView.mas_right).offset(-15);
        }];
    }else{
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(20);
            make.left.equalTo(self.contentView.mas_left).offset(15);
            make.right.equalTo(self.contentView.mas_right).offset(-15);
        }];
    }
    
    if (self.describe == nil || [self.describe isEqualToString:@""]) {
        [self.detailLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(0);
            make.left.equalTo(self.titleLabel.mas_left);
            make.right.equalTo(self.titleLabel.mas_right);
        }];
    }else
    {
        if (self.titleString == nil || [self.titleString isEqualToString:@""]) {
            [self.detailLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.titleLabel.mas_bottom).offset(20);
                make.left.equalTo(self.titleLabel.mas_left);
                make.right.equalTo(self.titleLabel.mas_right);
            }];
        }else{
            [self.detailLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
                make.left.equalTo(self.titleLabel.mas_left);
                make.right.equalTo(self.titleLabel.mas_right);
            }];
        }
    }
    
    [self.hLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left);
        make.top.equalTo(self.detailLabel.mas_bottom).offset(20);
        make.right.equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(.5f);
    }];
    
    [self.vLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.hLine.mas_bottom);
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.width.mas_equalTo(.5f);
    }];
    
    [self.leftBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.hLine.mas_bottom);
        make.left.equalTo(self.contentView.mas_left);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.right.equalTo(self.vLine.mas_left);
        make.height.mas_equalTo(44);
    }];
    
    [self.rightBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.leftBtn.mas_top);
        make.left.equalTo(self.vLine.mas_right);
        make.bottom.equalTo(self.leftBtn.mas_bottom);
        make.right.equalTo(self.contentView.mas_right);
        make.height.equalTo(self.leftBtn.mas_height);
    }];
    
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(270);
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY);
    }];
}

-(void)setupSubViews
{
    self.view.backgroundColor = [UIColor clearColor];
    self.bgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.bgView.backgroundColor = [UIColor blackColor];
    self.bgView.alpha = .3f;
    
    self.contentView = [[UIView alloc] init];
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.contentView.layer.cornerRadius = 10;
    self.contentView.layer.masksToBounds = YES;
    
    self.hLine = [[UIView alloc] init];
    self.hLine.backgroundColor = [UIColor blueColor];
    
    self.vLine = [[UIView alloc] init];
    self.vLine.backgroundColor = [UIColor blueColor];
    
    self.leftBtn = [[UIButton alloc] init];
    self.leftBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.leftBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.leftBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.leftBtn addTarget:self action:@selector(leftBtnDidClicked) forControlEvents:UIControlEventTouchUpInside];

    self.rightBtn = [[UIButton alloc] init];
    self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.rightBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(rightBtnDidClicked) forControlEvents:UIControlEventTouchUpInside];

    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = self.titleString;
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.preferredMaxLayoutWidth = 240;
    
    self.detailLabel = [[UILabel alloc] init];
    self.detailLabel.text = self.describe;
    self.detailLabel.textColor = [UIColor blackColor];
    self.detailLabel.font = [UIFont systemFontOfSize:13];
    self.detailLabel.textAlignment = NSTextAlignmentCenter;
    self.detailLabel.numberOfLines = 0;
    self.detailLabel.preferredMaxLayoutWidth = 240;

    [self.contentView addSubview:self.hLine];
    [self.contentView addSubview:self.vLine];
    [self.contentView addSubview:self.leftBtn];
    [self.contentView addSubview:self.rightBtn];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.detailLabel];

    [self.view addSubview:self.bgView];
    [self.view addSubview:self.contentView];
}

@end
