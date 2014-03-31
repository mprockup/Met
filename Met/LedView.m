//
//  LedView.m
//  Met
//
//  Created by Matthew Prockup on 10/15/13.
//  Copyright (c) 2013 Matthew Prockup. All rights reserved.
//

#import "LedView.h"

@implementation LedView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.hidden = false;
        self.alpha = 0;
        // Initialization code
    }
    return self;
}

-(void)setIntensity:(float)intensity
{
    self.hidden = false;
    self.alpha = intensity;
}
-(void)turnOn
{
    self.hidden = false;
    self.alpha = 0;
}
-(void)dim
{
    self.alpha = 0;
}
-(void)turnOff
{
    self.hidden = true;
}
-(bool)isOn{
    return !self.hidden;
}
-(bool)isOff
{
    return self.hidden;
}
-(void)blink:(double)fadeSecs
{
    self.alpha = self.alpha*10;
    [self setNeedsDisplay];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:fadeSecs];
    [self setAlpha:self.alpha/4];
    [UIView commitAnimations];
}
-(void)blink:(double)fadeSecs withIntensity:(double)intensity
{
    if(intensity > 0.1)
    {
        self.alpha = intensity;
        [self setNeedsDisplay];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:fadeSecs];
        [self setAlpha:0.1];
        [UIView commitAnimations];
    }
    else{
        self.alpha = 0.0;
    }
    
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
