//
//  FLJInputAlertViewController.h
//  FLJAlertView
//
//  Created by 贾林飞 on 2018/1/12.
//  Copyright © 2018年 贾林飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLJInputAlertView : UIView

@property(nonatomic,strong)UITextField* inputField;

//由于键盘弹出后，在输入时会更新frame，latestFrame保存键盘弹出后的frame
@property(nonatomic,assign)CGRect latestFrame;

@property(nonatomic,copy)dispatch_block_t cancelBlock;

@property(nonatomic,copy)dispatch_block_t completionBlock;

@end
