//
//  RelatedPickerViewController.h
//  FLJAlertView
//
//  Created by 贾林飞 on 2018/1/23.
//  Copyright © 2018年 贾林飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RelatedPickerViewController : UIViewController

@property(nonatomic,copy)void(^selectBlock)(NSString* selectString1,NSString* selectString2);

-(instancetype)initWithListArray:(NSArray*)array;

@end
