//
//  FLJQRScanView.m
//  FLJAlertView
//
//  Created by 贾林飞 on 2018/1/24.
//  Copyright © 2018年 贾林飞. All rights reserved.
//

#import "FLJQRScanView.h"

@interface FLJQRScanView ()

@property (nonatomic, strong) CALayer *lineLayer;

@end

@implementation FLJQRScanView

- (void)drawRect:(CGRect)rect
{
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    CGFloat pickingFieldWidth = 300;
    CGFloat pickingFieldHeight = 300;
    
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextSaveGState(contextRef);
    CGContextSetRGBFillColor(contextRef, 0, 0, 0, 0.35);
    CGContextSetLineWidth(contextRef, 3);
    
    CGRect pickingFieldRect = CGRectMake((width - pickingFieldWidth) / 2, (height - pickingFieldHeight) / 2, pickingFieldWidth, pickingFieldHeight);
    
    UIBezierPath *pickingFieldPath = [UIBezierPath bezierPathWithRect:pickingFieldRect];
    UIBezierPath *bezierPathRect = [UIBezierPath bezierPathWithRect:rect];
    [bezierPathRect appendPath:pickingFieldPath];
    //填充使用奇偶法则
    bezierPathRect.usesEvenOddFillRule = YES;
    [bezierPathRect fill];
    CGContextSetLineWidth(contextRef, 2);
    CGContextSetRGBStrokeColor(contextRef, 27/255.0, 181/255.0, 254/255.0, 1);
    //    CGFloat dash[2] = {4,4};
    //    [pickingFieldPath setLineDash:dash count:2 phase:0];
    [pickingFieldPath stroke];
    
    CGContextRestoreGState(contextRef);
    self.layer.contentsGravity = kCAGravityCenter;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        
        self.lineLayer = [CALayer layer];
        self.lineLayer.contents = (id)[UIImage imageNamed:@"line"].CGImage;
        [self.layer addSublayer:self.lineLayer];
        [self resumeAnimation];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(resumeAnimation) name:UIApplicationDidBecomeActiveNotification object:nil];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(stopAnimation) name:UIApplicationDidEnterBackgroundNotification object:nil];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self setNeedsDisplay];
    
    self.lineLayer.frame = CGRectMake((self.frame.size.width - 300) / 2, (self.frame.size.height - 300) / 2, 300, 2);
}

- (void)stopAnimation
{
    [self.lineLayer removeAnimationForKey:@"translationY"];
}

- (void)resumeAnimation
{
    CABasicAnimation *basic = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    basic.fromValue = @(0);
    basic.toValue = @(300);
    basic.duration = 1.5;
    basic.repeatCount = NSIntegerMax;
    [self.lineLayer addAnimation:basic forKey:@"translationY"];
}

@end
