//
//  RootViewController.h
//  RotationImage
//
//  Created by JatWaston on 14-6-19.
//  Copyright (c) 2014年 JatWaston. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController
{
    UIImageView *_imageView;
    CGPoint _lastPos;
    CGFloat _lastScale;
    CGFloat _lastRotation;
}

@end
