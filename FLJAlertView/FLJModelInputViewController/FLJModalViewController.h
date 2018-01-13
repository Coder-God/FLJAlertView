//
//  FLJViewController.h
//  FLJAlertView
//
//  Created by 贾林飞 on 2018/1/9.
//  Copyright © 2018年 贾林飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLJInputAlertView.h"

@interface FLJModalViewController : UIViewController

@property(nonatomic,strong)UIView* bgView;

@property(nonatomic,strong)FLJInputAlertView* alertView;

+(instancetype)creatAlertVC;

@end
