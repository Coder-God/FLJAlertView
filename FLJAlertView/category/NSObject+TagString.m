//
//  UIViewController+TagString.m
//  FLJAlertView
//
//  Created by 贾林飞 on 2018/1/12.
//  Copyright © 2018年 贾林飞. All rights reserved.
//

#import "NSObject+TagString.h"
#import <objc/runtime.h>

@implementation NSObject (TagString)

-(void)setTagString:(NSString *)tagString
{
    objc_setAssociatedObject(self, @selector(tagString), tagString, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(NSString *)tagString
{
   return objc_getAssociatedObject(self, @selector(tagString));
}
@end
