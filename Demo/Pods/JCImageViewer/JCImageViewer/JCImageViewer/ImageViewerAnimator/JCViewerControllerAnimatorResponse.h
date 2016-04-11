//
//  JCViewerControllerAnimatorResponse.h
//  JCImageViewer
//
//  Created by chenjie on 16/4/9.
//  Copyright © 2016年 jiechen. All rights reserved.
//

#import "JCIVAnimatorResponse.h"
#import "JCImageViewerView.h"

@interface JCViewerControllerAnimatorResponse : JCIVAnimatorResponse

@property (nonatomic, weak) JCImageViewerView *viewer;
@property (nonatomic, weak) UIImageView *defaultView;

@end
