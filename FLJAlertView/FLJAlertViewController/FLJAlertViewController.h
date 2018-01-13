//
//  FLJAlertViewController.h
//  FLJAlertView
//
//  Created by 贾林飞 on 2018/1/12.
//  Copyright © 2018年 贾林飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLJAlertViewController : UIViewController

@property(nonatomic,copy)NSString* leftBtnTitle;

@property(nonatomic,copy)NSString* rightBtntitle;

@property(nonatomic,copy)dispatch_block_t leftBtnAction;

@property(nonatomic,copy)dispatch_block_t rightBtnAction;

+(instancetype)alertViewControllerWithTitle:(NSString*)title description:(NSString*)description;

-(void)executeAlertShowAnimationWithDuration:(CGFloat)duration completionBlock:(void(^)(void))completionBlock;

-(void)executeAlertHideAnimationWithDuration:(CGFloat)duration completionBlock:(void(^)(void))completionBlock;

@end
