//
//  JCImageViewerAnimationTransition.m
//  JCImageViewer
//
//  Created by jiechen on 16/4/7.
//  Copyright © 2016年 jiechen. All rights reserved.
//

#import "JCImageViewerAnimationTransition.h"
#import "JCImageViewerAnimatorProtocol.h"

@implementation JCImageViewerAnimationTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.35;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    NSAssert([fromVC conformsToProtocol:@protocol(JCImageViewerAnimatorProtocol)] && [toVC conformsToProtocol:@protocol(JCImageViewerAnimatorProtocol)], @"fromVC 和 toVC必须遵循协议 ImageViewerResponseProtocol");
    
    UIView *containerView = [transitionContext containerView];
    //UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;
    [containerView addSubview:toView];
    
    CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
    UIView *backgroundView = [[UIView alloc] initWithFrame:finalFrame];
    backgroundView.backgroundColor = [UIColor blackColor];
    [containerView addSubview:backgroundView];
    
    id<JCIVAnimatorResponseProtocol> fromResponse = [(id<JCImageViewerAnimatorProtocol>)fromVC imageViewerAnimatorResponse];
    id<JCIVAnimatorResponseProtocol> toResponse = [(id<JCImageViewerAnimatorProtocol>)toVC imageViewerAnimatorResponse];
    int index = [fromResponse currentImageIndex];
    UIImageView *fromImageView = [fromResponse animationImageViewWithIndex:index];
    UIImageView *toImageView = [toResponse animationImageViewWithIndex:index];
    CGRect fromFrame = [fromImageView convertRect:fromImageView.bounds toView:containerView];
    CGRect toFrame = [toImageView convertRect:toImageView.bounds toView:containerView];
    
    UIImageView *phImageView = [[UIImageView alloc] initWithFrame:fromFrame];
    phImageView.image = fromImageView.image;
    phImageView.contentMode = UIViewContentModeScaleAspectFit;
    phImageView.clipsToBounds = YES;
    [containerView addSubview:phImageView];
    
    toView.alpha = 0;
    if (self.isDismiss) {
        backgroundView.alpha = 1;
    } else {
        backgroundView.alpha = 0;
    }
    
    CGFloat duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        toView.alpha = 1;
        phImageView.frame = toFrame;
        if (self.isDismiss) {
            backgroundView.alpha = 0;
        } else {
            backgroundView.alpha = 1;
        }
    } completion:^(BOOL finished) {
        [phImageView removeFromSuperview];
        [backgroundView removeFromSuperview];
        
        BOOL isCancelled = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!isCancelled];
    }];
}

@end
