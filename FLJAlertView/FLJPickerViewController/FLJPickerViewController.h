//
//  FLJPickerViewController.h
//  FLJAlertView
//
//  Created by 贾林飞 on 2018/1/23.
//  Copyright © 2018年 贾林飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLJPickerViewController : UIViewController

@property(nonatomic,copy)void(^selectBlock)(NSString* selectString);

/**
 创建

 @param array 字符串数组
 */
-(instancetype)initWithListArray:(NSArray*)array;

@end
