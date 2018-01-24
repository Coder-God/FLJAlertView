//
//  UIViewController+MessageAlert.h
//  FLJAlertView
//
//  Created by 贾林飞 on 2018/1/24.
//  Copyright © 2018年 贾林飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (MessageAlert)

-(void)showAlertWithTitle:(NSString*)title message:(NSString*)message handler:(void(^)(UIAlertAction* action))handler;

@end
