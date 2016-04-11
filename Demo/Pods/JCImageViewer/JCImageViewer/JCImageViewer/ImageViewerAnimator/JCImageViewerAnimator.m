//
//  JCImageViewerAnimator.m
//  JCImageViewer
//
//  Created by jiechen on 16/4/7.
//  Copyright © 2016年 jiechen. All rights reserved.
//

#import "JCImageViewerAnimator.h"
#import "JCImageViewerAnimationTransition.h"
#import "JCImageViewerAnimatorProtocol.h"
#import "UINavigationController+JCImageViewer.h"
#import "UITabBarController+JCImageVIewer.h"

@interface JCImageViewerAnimator ()

@property (nonatomic, strong) JCImageViewerAnimationTransition *animatorTranstion;

@end

@implementation JCImageViewerAnimator

+ (instancetype)sharedAnimator {
    static JCImageViewerAnimator *animator = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        animator = [JCImageViewerAnimator new];
    });
    return animator;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    
    if ([source conformsToProtocol:@protocol(JCImageViewerAnimatorProtocol)]
        && [presenting conformsToProtocol:@protocol(JCImageViewerAnimatorProtocol)]
        && [self viewControllerIsImageViewer:presented]) {
        
        if ([presenting isKindOfClass:[UINavigationController class]]
            || [presenting isKindOfClass:[UITabBarController class]]) {
            
            id<JCIVAnimatorResponseProtocol> sResponse = [(id<JCImageViewerAnimatorProtocol>)source imageViewerAnimatorResponse];
            [(id<JCImageViewerAnimatorProtocol>)presenting setAnimatorResponse:sResponse];
        }
        self.animatorTranstion.isDismiss = NO;
        return self.animatorTranstion;
    }
    
    return nil;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    
    if ([self viewControllerIsImageViewer:dismissed]) {
        self.animatorTranstion.isDismiss = YES;
        return self.animatorTranstion;
    }
    
    return nil;
}

#pragma mark -
- (JCImageViewerAnimationTransition *)animatorTranstion {
    if (!_animatorTranstion) {
        _animatorTranstion = [JCImageViewerAnimationTransition new];
    }
    return _animatorTranstion;
}

- (BOOL)viewControllerIsImageViewer:(UIViewController *)controller {
    return [controller isKindOfClass:NSClassFromString(@"JCImageViewerController")];
}

@end
