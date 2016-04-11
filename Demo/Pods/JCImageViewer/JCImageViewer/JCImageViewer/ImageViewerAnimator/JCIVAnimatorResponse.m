//
//  JCIVAnimatorResponse.m
//  JCImageViewer
//
//  Created by chenjie on 16/4/9.
//  Copyright © 2016年 jiechen. All rights reserved.
//

#import "JCIVAnimatorResponse.h"

@implementation JCIVAnimatorResponse

- (int)currentImageIndex {
    return self.currentIndex;
}

- (UIImageView *)animationImageViewWithIndex:(int)index {
    if (index < self.dataArray.count) {
        if (![self.dataArray[index] isKindOfClass:NSClassFromString(@"UIImageView")]) {
            NSAssert(NO, @"子类必须重写该方法，返回UIImageView的实例");
        }
        return self.dataArray[index];
    }
    return nil;
}

@end
