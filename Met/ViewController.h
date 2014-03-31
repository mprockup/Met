//
//  ViewController.h
//  Met
//
//  Created by Matthew Prockup on 9/26/13.
//  Copyright (c) 2013 Matthew Prockup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MixerHostAudio.h"
#import "BeepObject.h"
#import "SwipeLabel.h"
#import "LedView.h"
@interface ViewController : UIViewController <UIGestureRecognizerDelegate>
{
    
    int currentPreset;
    int totalPresets;
    BeepObject* beepObj1;
    BeepObject* beepObj2;
    BeepObject* beepObj3;
    BeepObject* beepObj4;
    
    NSMutableArray* ledViews;
    AudioComponentInstance toneUnit;
    
    UIButton *playButton;
    UIButton *loadButton;
    
    UISwitch        *mixerBus0Switch;
    UISwitch        *mixerBus1Switch;
    UISwitch        *mixerBus2Switch;
    UISwitch        *mixerBus3Switch;
    
    UISlider        *mixerBus0LevelFader;
    UISlider        *mixerBus1LevelFader;
    UISlider        *mixerBus2LevelFader;
    UISlider        *mixerBus3LevelFader;
    UISlider        *mixerOutputLevelFader;
    NSMutableArray  *beepObjects;
    
    SwipeLabel* tempoLabel;
    
    UIView* backgroundView;
    
@public
    double sampleRate;
    
}

- (void)stop;
- (float*)getDataOnChannel:(int)channel withFrames:(int)numFrame;
- (void)createToneUnit;
- (void)startAudio;
- (void)beepMethod;

@property (nonatomic, retain)    IBOutlet UISlider           *mixerBus0LevelFader;
@property (nonatomic, retain)    IBOutlet UISlider           *mixerBus1LevelFader;
@property (nonatomic, retain)    IBOutlet UISlider           *mixerBus2LevelFader;
@property (nonatomic, retain)    IBOutlet UISlider           *mixerBus3LevelFader;
@property (nonatomic, retain)    IBOutlet UISlider           *mixerOutputLevelFader;

@property (nonatomic, retain)    IBOutlet UIButton           *playButton;
@property (nonatomic, retain)    IBOutlet UIButton           *loadButton;

@property (nonatomic, retain)    IBOutlet UISwitch           *mixerBus0Switch;
@property (nonatomic, retain)    IBOutlet UISwitch           *mixerBus1Switch;
@property (nonatomic, retain)    IBOutlet UISwitch           *mixerBus2Switch;
@property (nonatomic, retain)    IBOutlet UISwitch           *mixerBus3Switch;

@property (nonatomic, retain)    IBOutlet SwipeLabel           *tempoLabel;
@property (nonatomic, retain)    IBOutlet UILabel           *tempProgramLabel;
@property (nonatomic, retain)    IBOutlet UIView           *backgroundView;
@property (nonatomic, strong) IBOutlet UILongPressGestureRecognizer *savePresetGesture;
@property (nonatomic, strong) IBOutlet UISwipeGestureRecognizer *presetUpGesture;
@property (nonatomic, strong) IBOutlet UISwipeGestureRecognizer *presetDownGesture;


- (IBAction) enableMixerInput:          (UISwitch *) sender;
- (IBAction) mixerInputGainChanged:     (UISlider *) sender;
- (IBAction) mixerOutputGainChanged:    (UISlider *) sender;
- (IBAction) playOrStop:                (id) sender;
- (IBAction)saveGesturePressed:(UILongPressGestureRecognizer *)recognizer;
- (IBAction)presetUpSwipe:(UISwipeGestureRecognizer *)recognizer;
- (IBAction)presetDownSwipe:(UISwipeGestureRecognizer *)recognizer;


@property (nonatomic, retain) MixerHostAudio *audioObject;

@end
