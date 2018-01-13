//
//  FLJInputAlertViewController.m
//  FLJAlertView
//
//  Created by 贾林飞 on 2018/1/12.
//  Copyright © 2018年 贾林飞. All rights reserved.
//

#import "FLJInputAlertView.h"
#import <Masonry.h>

@interface FLJInputAlertView ()

@property(nonatomic,strong)UIView* topBgView;

@property(nonatomic,strong)UIImageView* imageView;

@property(nonatomic,strong)UILabel* intruduceLabel;

@property(nonatomic,strong)UIButton* completeBtn;

@property(nonatomic,strong)UIButton* cancelBtn;

@end

@implementation FLJInputAlertView

-(instancetype)init
{
    if (self == [super init]) {
        [self setUpSubViews];
    }
    return self;
}

-(void)keyboardWillShowNotification:(NSNotification*)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    double duration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardRect = [aValue CGRectValue];
    
//    CGFloat keyboardHeight = keyboardRect.size.height;
    
    CGRect selfWindowFrame = [self convertRect:self.bounds toView:[UIApplication sharedApplication].keyWindow];
    CGFloat margin = 10.f;
    if (CGRectGetMaxY(selfWindowFrame) >keyboardRect.origin.y) {
        margin +=(CGRectGetMaxY(selfWindowFrame) - keyboardRect.origin.y);
    }
    
   __block CGFloat y = self.frame.origin.y;
    [UIView animateWithDuration:duration animations:^{
        y = y - margin;
        self.frame =CGRectMake(self.frame.origin.x, y, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        self.latestFrame = self.frame;
    } completion:^(BOOL finished) {
        
    }];
}

-(void)keyboardWillHideNotification:(NSNotification*)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    double duration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
//    CGRect keyboardRect = [aValue CGRectValue];
    //    CGFloat keyboardHeight = keyboardRect.size.height;
    //
    //    CGRect selfWindowFrame = [self convertRect:self.bounds toView:[UIApplication sharedApplication].keyWindow];
    
    [UIView animateWithDuration:duration animations:^{
        self.center = self.superview.center;
    } completion:^(BOOL finished) {
        
    }];
    
}

-(void)cancelBtnDidClicked
{
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}

-(void)completeBtnDidClciked
{
    if (self.completionBlock) {
        self.completionBlock();
    }
}

-(void)setUpSubViews
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];

    self.layer.cornerRadius = 7;
    self.layer.masksToBounds = YES;
    
    self.backgroundColor = [UIColor whiteColor];
    self.imageView = [[UIImageView alloc]init];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.image = [UIImage imageNamed:@"image_subscription_add"];
    
    self.topBgView = [[UIView alloc]init];
    self.topBgView.backgroundColor = [UIColor colorWithRed:236 green:236 blue:236 alpha:1.f];
    
    self.inputField = [[UITextField alloc]init];
    self.inputField.font = [UIFont systemFontOfSize:13];
    self.inputField.layer.cornerRadius = 4;
    self.inputField.layer.masksToBounds = YES;
    self.inputField.layer.borderColor = [UIColor colorWithRed:243/255.f green:204/255.f blue:208/255.f alpha:1.f].CGColor;
    self.inputField.layer.borderWidth = .5f;
    self.inputField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 10)];
    self.inputField.leftViewMode = UITextFieldViewModeAlways;
    [self.inputField performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:.3f];
    
    self.completeBtn = [[UIButton alloc]init];
    self.completeBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    self.completeBtn.backgroundColor = [UIColor colorWithRed:216/255.f green:81/255.f blue:95/255.f alpha:1.f];
    self.completeBtn.layer.cornerRadius = 2;
    self.completeBtn.layer.masksToBounds = YES;
    self.completeBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.completeBtn setTitle:@"完 成" forState:UIControlStateNormal];
    [self.completeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.completeBtn addTarget:self action:@selector(completeBtnDidClciked) forControlEvents:UIControlEventTouchUpInside];
    
    self.cancelBtn = [[UIButton alloc]init];
    [self.cancelBtn setImage:[UIImage imageNamed:@"btn_tkl_close"] forState:UIControlStateNormal];
    [self.cancelBtn addTarget:self action:@selector(cancelBtnDidClicked) forControlEvents:UIControlEventTouchUpInside];
    
    self.intruduceLabel = [[UILabel alloc]init];
    self.intruduceLabel.textColor = [UIColor colorWithRed:102/255.f green:102/255.f blue:102/255.f alpha:1.f];
    self.intruduceLabel.font = [UIFont systemFontOfSize:14];
    self.intruduceLabel.textAlignment = NSTextAlignmentCenter;
    self.intruduceLabel.numberOfLines = 0;
    
    NSMutableParagraphStyle* style = [[NSMutableParagraphStyle alloc]init];
    style.lineSpacing = 3;
    style.alignment = NSTextAlignmentCenter;
    NSMutableAttributedString* string = [[NSMutableAttributedString alloc] initWithString:@"推荐使用更精确的词汇,如:耐克,女士马丁靴,薯片..."];
    [string addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, string.length)];
    self.intruduceLabel.attributedText = string;
    
    [self addSubview:self.topBgView];
    [self addSubview:self.imageView];
    [self addSubview:self.inputField];
    [self addSubview:self.intruduceLabel];
    [self addSubview:self.completeBtn];
    [self addSubview:self.cancelBtn];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.topBgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(0);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(190);
    }];
    
    [self.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(0);
        make.left.equalTo(self.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
        make.bottom.equalTo(self.topBgView.mas_bottom);
    }];
    
    [self.inputField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_bottom).offset(10);
        make.right.equalTo(self.mas_right).offset(-15);
        make.left.equalTo(self.mas_left).offset(15);
        make.height.mas_equalTo(30);
    }];
    
    [self.intruduceLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.inputField.mas_bottom).offset(10);
        make.right.equalTo(self.mas_right).offset(-15);
        make.left.equalTo(self.mas_left).offset(15);
    }];
    
    [self.completeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.intruduceLabel.mas_bottom).offset(10);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        make.size.mas_equalTo(CGSizeMake(120, 30));
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    [self.cancelBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
}

@end
