//
//  SwipeLabel.h
//  Met
//
//  Created by Matthew Prockup on 10/3/13.
//  Copyright (c) 2013 Matthew Prockup. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwipeLabel : UILabel
{
    int touchDisplacement;
    int lastTouchPos;
    int currentValue;
    bool didMove;
}
@property (nonatomic) int lowerBound;
@property (nonatomic) int upperBound;
@property (nonatomic) bool multipleSwipe;
@end
