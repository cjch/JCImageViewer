//
//  JCImageViewerController.h
//  JCImageViewer
//
//  Created by jiechen on 16/4/7.
//  Copyright © 2016年 jiechen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCImageViewerController : UIViewController

+ (instancetype)getInstanceWithData:(NSArray *)dataArray showIndex:(int)index;

- (void)showWithIndex:(int)index;

@end
