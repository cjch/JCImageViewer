//
//  UITabBarController+JCImageVIewer.m
//  JCImageViewer
//
//  Created by jiechen on 16/4/7.
//  Copyright © 2016年 jiechen. All rights reserved.
//

#import "UITabBarController+JCImageVIewer.h"
#import <objc/runtime.h>

static NSString * const TabbarJCImageViewerResponseKey = @"com.jc.imageviewer.tabbar";

@implementation UITabBarController (JCImageViewer)

- (id<JCIVAnimatorResponseProtocol>)imageViewerAnimatorResponse {
    return objc_getAssociatedObject(self, &TabbarJCImageViewerResponseKey);
}

- (void)setAnimatorResponse:(id<JCIVAnimatorResponseProtocol>)response {
    objc_setAssociatedObject(self, &TabbarJCImageViewerResponseKey, response, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
