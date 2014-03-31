//
//  BeepObject.h
//  Met
//
//  Created by Matthew Prockup on 9/26/13.
//  Copyright (c) 2013 Matthew Prockup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AudioUnit/AudioUnit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "AudioSample.h"

@interface BeepObject : NSObject
{
    
    int objID;
    SourceAudioBufferData *SourceAudioBufferDataPtr;
    
    SoundBuffer *SoundBufferPtr;
    
    CFURLRef sourceURL[NUMFILES];
    
    SourceAudioBufferData mUserData;
    
    AudioStreamBasicDescription mClientFormat;
    AudioStreamBasicDescription mOutputFormat;
    int audiosize;
    AudioUnitSampleType* playingAudio;
    
@public
    double sampleRate;
    NSString* beepName;
    AudioSample* currentSample;
}
- (void)getAudioData:(AudioUnitSampleType*)buffer onChannel:(int)chan withFrames:(int)numFrames;
- (void)addAudioData:(AudioUnitSampleType*)buffer onChannel:(int)chan withFrames:(int)numFrames withGain:(float)gain;
- (void)loadAudioData;
- (NSString *)OSStatusToStr:(OSStatus)st;

- (void)initializeTrackWithSound:(NSString*)sound;
-(void) makeBeep;
//@property float maxTap;
@end
