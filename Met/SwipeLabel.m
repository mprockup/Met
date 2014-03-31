//
//  SwipeLabel.m
//  Met
//
//  Created by Matthew Prockup on 10/3/13.
//  Copyright (c) 2013 Matthew Prockup. All rights reserved.
//

#import "SwipeLabel.h"

@implementation SwipeLabel
@synthesize upperBound, lowerBound, multipleSwipe;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        lowerBound = 1;
        upperBound = 10;
        multipleSwipe = false;
    }
    return self;
}


#pragma mark Touch Code
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:touch.view];
    touchDisplacement = location.x-lastTouchPos;
    lastTouchPos = location.x;
    NSLog(@"TOUCH MOVED");
    
    if(multipleSwipe)
    {
        currentValue = currentValue-touchDisplacement;
    }
    else
    {
        if(!didMove)
        {
            if(touchDisplacement>0)
            {
                currentValue -= 1;
            }
            else
            {
                currentValue += 1;
            }
            
            
        }
    }

    if(currentValue<lowerBound)
    {
        currentValue = lowerBound;
    }
    
    if(currentValue>upperBound)
    {
        currentValue = upperBound;
    }
    
    didMove = true;
    
    
    self.text = [NSString stringWithFormat:@"%d", currentValue];
    
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesBegan");
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:touch.view];
    lastTouchPos = location.x;
    touchDisplacement = 0;
    currentValue = [self.text floatValue];
    didMove = false;
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [[event allTouches] anyObject];
    NSLog(@"TOUCH END");
    lastTouchPos = 0;
    touchDisplacement = 0;
    CGPoint location = [touch locationInView:touch.view];
    if(!didMove)
    {
        CGRect labelSize = [self bounds];
        int labelWidth = labelSize.size.width;
        if(location.x> labelWidth*(2/3))
        {
            currentValue = currentValue+1;
            
            if(currentValue<lowerBound)
            {
                currentValue = lowerBound;
            }
            
            if(currentValue>upperBound)
            {
                currentValue = upperBound;
            }
            
            self.text = [NSString stringWithFormat:@"%d", currentValue];
        }
        else if(location.x< labelWidth/3)
        {
            currentValue = currentValue-1;
            
            if(currentValue<lowerBound)
            {
                currentValue = lowerBound;
            }
            
            if(currentValue>upperBound)
            {
                currentValue = upperBound;
            }
            
            self.text = [NSString stringWithFormat:@"%d", currentValue];
        }
    }
    didMove = false;
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
