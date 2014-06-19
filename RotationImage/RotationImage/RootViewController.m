//
//  RootViewController.m
//  RotationImage
//
//  Created by JatWaston on 14-6-19.
//  Copyright (c) 2014年 JatWaston. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    _lastPos = CGPointMake(0.0f, 0.0f);
    _lastScale = 1.0f;
    _lastRotation = 0.0f;
    
    UIImage *image = [UIImage imageNamed:@"test.jpg"];
    _imageView = [[UIImageView alloc] initWithImage:image];
    _imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    _imageView.userInteractionEnabled = YES;
    
    //rotation
    UIRotationGestureRecognizer *rotationGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotation:)];
    [_imageView addGestureRecognizer:rotationGesture];
    
    //scale
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handleScale:)];
    [_imageView addGestureRecognizer:pinchGesture];
    
    //move
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleMove:)];
    [panGesture setMinimumNumberOfTouches:1];
    [panGesture setMaximumNumberOfTouches:1];
    [_imageView addGestureRecognizer:panGesture];
    
    [self.view addSubview:_imageView];
}

- (void)handleRotation:(UIRotationGestureRecognizer*)recognizer
{
    if([recognizer state] == UIGestureRecognizerStateEnded)
    {
        _lastRotation = 0.0;
        return;
    }
    
    CGFloat rotation = -_lastRotation + [recognizer rotation];
    
    CGAffineTransform currentTransform = _imageView.transform;
    CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform,rotation);
    [_imageView setTransform:newTransform];
    
    _lastRotation = [recognizer rotation];
}

- (void)handleScale:(UIPinchGestureRecognizer*)recognizer
{
    if([recognizer state] == UIGestureRecognizerStateBegan)
    {
        _lastScale = 1.0;
        return;
    }
    
    CGFloat scale = [recognizer scale]/_lastScale;
    CGAffineTransform currentTransform = _imageView.transform;
    CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, scale, scale);
    [_imageView setTransform:newTransform];
    _lastScale = [recognizer scale];
}

- (void)handleMove:(UIPanGestureRecognizer*)recognizer
{
    CGPoint translatedPoint = [recognizer translationInView:self.view];
    
    if([recognizer state] == UIGestureRecognizerStateBegan)
    {
        _lastPos = CGPointMake(0.0f, 0.0f);
    }
    
    CGAffineTransform trans = CGAffineTransformMakeTranslation(translatedPoint.x - _lastPos.x, translatedPoint.y - _lastPos.y);
    CGAffineTransform newTransform = CGAffineTransformConcat(_imageView.transform, trans);
    _lastPos = CGPointMake(translatedPoint.x, translatedPoint.y);
    _imageView.transform = newTransform;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
