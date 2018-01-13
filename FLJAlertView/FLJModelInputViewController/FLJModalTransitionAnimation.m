//
//  FLJTransitionAnimation.m
//  FLJAlertView
//
//  Created by 贾林飞 on 2018/1/9.
//  Copyright © 2018年 贾林飞. All rights reserved.
//

#import "FLJModalTransitionAnimation.h"
#import "FLJModalViewController.h"

@implementation FLJModalTransitionAnimation

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController* fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController* toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    if ([fromVC.presentedViewController isEqual:toVC]) {
        return .3f;
    }else if([fromVC.presentingViewController isEqual:toVC])
    {
        return .3f;
    }
    return .3f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController* fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController* toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView* containerView = [transitionContext containerView];
    
    CGFloat duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration animations:^{
        if ([toVC isKindOfClass:[FLJModalViewController class]]) {
            FLJModalViewController* VC = (FLJModalViewController*)toVC;
            VC.bgView.alpha = 0.3f;
            [containerView addSubview:toVC.view];

            CAKeyframeAnimation* animation = [CAKeyframeAnimation animation];
            animation.keyPath = @"transform";
            animation.duration = duration;

            NSMutableArray *values = [NSMutableArray array];
            [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
            [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
            [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1.0)]];
            [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
            [values addObject:[NSValue valueWithCATransform3D:CATransform3DIdentity]];
            animation.values = values;

            [VC.alertView.layer removeAllAnimations];
            [VC.alertView.layer addAnimation:animation forKey:nil];

        }else{
            //dismiss的时候，layer的3d动画好像不执行
            FLJModalViewController* VC = (FLJModalViewController*)fromVC;
            VC.bgView.alpha = .0f;
            VC.alertView.transform = CGAffineTransformMakeScale(1.f, 1.f);
            VC.alertView.transform = CGAffineTransformMakeScale(.1f, .1f);
        }
    } completion:^(BOOL finished) {
        BOOL wasCancelled = [transitionContext transitionWasCancelled];
//        设置transitionContext通知系统动画执行完毕
        [transitionContext completeTransition:!wasCancelled];
    }];
}
@end
