//
//  FLJAlertTransionAnimation.m
//  FLJAlertView
//
//  Created by 贾林飞 on 2018/1/12.
//  Copyright © 2018年 贾林飞. All rights reserved.
//

#import "FLJAlertTransionAnimation.h"
#import "FLJAlertViewController.h"

@implementation FLJAlertTransionAnimation

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController* fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController* toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    if ([fromVC.presentedViewController isEqual:toVC]) {
        return .3f;
    }else if([fromVC.presentingViewController isEqual:toVC])
    {
        return .1f;
    }
    return .3f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController* fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController* toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    CGFloat duration = [self transitionDuration:transitionContext];
    UIView* containerView = [transitionContext containerView];
    BOOL isPresent = NO;
    if ([toVC isKindOfClass:[FLJAlertViewController class]]) {
        isPresent = YES;
        [containerView addSubview:toVC.view];
        FLJAlertViewController* VC = (FLJAlertViewController*)toVC;
        [VC executeAlertShowAnimationWithDuration:duration completionBlock:^{
            BOOL wasCancelled = [transitionContext transitionWasCancelled];
            //        设置transitionContext通知系统动画执行完毕
            [transitionContext completeTransition:!wasCancelled];
        }];
    }else
    {
        FLJAlertViewController* VC = (FLJAlertViewController*)fromVC;
        [VC executeAlertHideAnimationWithDuration:duration completionBlock:^{
            BOOL wasCancelled = [transitionContext transitionWasCancelled];
            //        设置transitionContext通知系统动画执行完毕
            [transitionContext completeTransition:!wasCancelled];
        }];
    }
}

@end
