//
//  JCImageViewerAnimator.h
//  JCImageViewer
//
//  Created by jiechen on 16/4/7.
//  Copyright © 2016年 jiechen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JCImageViewerAnimator : NSObject <UIViewControllerTransitioningDelegate>

+ (instancetype)sharedAnimator;

@end
