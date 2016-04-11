//
//  UINavigationController+JCImageViewer.m
//  JCImageViewer
//
//  Created by jiechen on 16/4/7.
//  Copyright © 2016年 jiechen. All rights reserved.
//

#import "UINavigationController+JCImageViewer.h"
#import <objc/runtime.h>

static NSString * const NavJCImageViewerResponseKey = @"com.jc.imageviewer.navigation";

@implementation UINavigationController (JCImageViewer)

- (id<JCIVAnimatorResponseProtocol>)imageViewerAnimatorResponse {
    return objc_getAssociatedObject(self, &NavJCImageViewerResponseKey);
}

- (void)setAnimatorResponse:(id<JCIVAnimatorResponseProtocol>)response {
    objc_setAssociatedObject(self, &NavJCImageViewerResponseKey, response, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
