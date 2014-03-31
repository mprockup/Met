//
//  LedView.h
//  Met
//
//  Created by Matthew Prockup on 10/15/13.
//  Copyright (c) 2013 Matthew Prockup. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LedView : UIView
-(void)setIntensity:(float)intensity;
-(void)turnOn;
-(void)turnOff;
-(bool)isOn;
-(bool)isOff;
-(void)dim;
-(void)blink:(double)fadeSecs;
-(void)blink:(double)fadeSecs withIntensity:(double)intensity;
@end
