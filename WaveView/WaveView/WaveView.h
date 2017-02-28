//
//  WaveView.h
//  WaveView
//
//  Created by 周松 on 17/2/28.
//  Copyright © 2017年 周松. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaveView : UIView

@property (nonatomic,assign) CGFloat angularSpeed;

@property (nonatomic,assign) CGFloat waveSpeed;

@property (nonatomic,assign) NSTimeInterval waveTime;

@property (nonatomic,strong) UIColor *waveColor;

+ (instancetype)addToView:(UIView *)view withFrame:(CGRect)frame;

- (BOOL)wave;
- (void)stop;

@end
