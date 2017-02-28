//
//  WaveView.m
//  WaveView
//
//  Created by 周松 on 17/2/28.
//  Copyright © 2017年 周松. All rights reserved.
//

#import "WaveView.h"


@interface WaveView ()

@property (nonatomic,assign) CGFloat offsetX;
@property (nonatomic,strong) CADisplayLink *waveDisplayLink;
@property (nonatomic,strong) CAShapeLayer *waveShapeLayer;

@end
@implementation WaveView

+ (instancetype)addToView:(UIView *)view withFrame:(CGRect)frame {
    WaveView *waveView = [[WaveView alloc]initWithFrame:frame];
    [view addSubview:waveView];
    return waveView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self basicSetup];
    }
    return self;
}

- (void)basicSetup {
    _angularSpeed = 2;
    _waveSpeed = 9;
    _waveTime = 1.5;
    _waveColor = [UIColor whiteColor];
}

- (BOOL)wave {
    if (self.waveShapeLayer.path) {
        return NO;
    }
    self.waveShapeLayer = [CAShapeLayer layer];
    self.waveShapeLayer.fillColor = self.waveColor.CGColor;
    [self.layer addSublayer:self.waveShapeLayer];
    
    self.waveDisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(currentWave)];
    [self.waveDisplayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
    if (self.waveTime > 0) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.waveTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self stop];
        });
    }
    
    return YES;
}

- (void)currentWave {
    self.offsetX -= self.waveSpeed * self.superview.frame.size.width / 320;
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    
    CGMutablePathRef path = CGPathCreateMutable();
    //设置移动到某点
    CGPathMoveToPoint(path, NULL, 0, height / 2);
    
    CGFloat y = 0;
    for (CGFloat x = 0; x <= width; x ++) {
        y = height * sin(0.01 * (self.angularSpeed * x + self.offsetX));
        CGPathAddLineToPoint(path, NULL, x, y);
    }
    CGPathAddLineToPoint(path, NULL, width, height);
    CGPathAddLineToPoint(path, NULL, 0, height);
    //闭合路径
    CGPathCloseSubpath(path);
    
    self.waveShapeLayer.path = path;
    //释放前面创建的路径
    CGPathRelease(path);
}

- (void)stop {
    [UIView animateWithDuration:1 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self.waveDisplayLink invalidate];
        self.waveDisplayLink = nil;
        self.waveShapeLayer.path = nil;
        self.alpha = 1;
    }];
}

@end








