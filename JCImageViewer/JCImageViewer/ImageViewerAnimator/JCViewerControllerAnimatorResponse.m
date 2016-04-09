//
//  JCViewerControllerAnimatorResponse.m
//  JCImageViewer
//
//  Created by chenjie on 16/4/9.
//  Copyright © 2016年 jiechen. All rights reserved.
//

#import "JCViewerControllerAnimatorResponse.h"
#import "JCImageZoomingView.h"

@implementation JCViewerControllerAnimatorResponse

- (int)currentImageIndex {
    return self.viewer.currentIndex;
}

- (UIImageView *)animationImageViewWithIndex:(int)index {
    UIImageView *resView = [self.viewer imageViewWithIndex:index];
    if (resView == nil) {
        resView = self.defaultView;
    }
    return resView;
}

@end
