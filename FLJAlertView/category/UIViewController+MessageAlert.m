//
//  UIViewController+MessageAlert.m
//  FLJAlertView
//
//  Created by 贾林飞 on 2018/1/24.
//  Copyright © 2018年 贾林飞. All rights reserved.
//

#import "UIViewController+MessageAlert.h"

@implementation UIViewController (MessageAlert)

-(void)showAlertWithTitle:(NSString *)title message:(NSString *)message handler:(void (^)(UIAlertAction *))handler
{
    UIAlertController* alertVc = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:handler];
    [alertVc addAction:sureAction];
    
    [self presentViewController:alertVc animated:YES completion:^{
        
    }];

}
@end
