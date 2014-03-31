//
//  ViewController.m
//  Met
//
//  Created by Matthew Prockup on 9/26/13.
//  Copyright (c) 2013 Matthew Prockup. All rights reserved.
//

#import "ViewController.h"



NSString *MixerHostAudioObjectPlaybackStateDidChangeNotification = @"MixerHostAudioObjectPlaybackStateDidChangeNotification";


@interface ViewController ()

@end

@implementation ViewController

@synthesize playButton;
@synthesize mixerBus0Switch;
@synthesize mixerBus0LevelFader;
@synthesize mixerBus1Switch;
@synthesize mixerBus1LevelFader;
@synthesize mixerBus2Switch;
@synthesize mixerBus2LevelFader;
@synthesize mixerBus3Switch;
@synthesize mixerBus3LevelFader;
@synthesize mixerOutputLevelFader;
@synthesize audioObject;
@synthesize tempoLabel;
@synthesize backgroundView;
@synthesize tempProgramLabel;

- (void) initializeMixerSettingsToUI {
    
    // Initialize mixer settings to UI
    
//    [audioObject setMixerOutputGain: mixerOutputLevelFader.value];
    [audioObject setMixerOutputGain: 1.0];

    [audioObject enableMixerInput: 0 isOn: true];
    [audioObject enableMixerInput: 1 isOn: true];
    [audioObject enableMixerInput: 2 isOn: true];
    [audioObject enableMixerInput: 3 isOn: true];
    
    [audioObject setMixerInput: 0 gain: mixerBus0LevelFader.value];
    [audioObject setMixerInput: 1 gain: mixerBus1LevelFader.value];
    [audioObject setMixerInput: 2 gain: mixerBus2LevelFader.value];
    [audioObject setMixerInput: 3 gain: mixerBus3LevelFader.value];
    

    
}

// Handle a change in the mixer output gain slider.
- (IBAction) mixerOutputGainChanged: (UISlider *) sender {
    
    [audioObject setMixerOutputGain: (AudioUnitParameterValue) sender.value];
}

// Handle a change in a mixer input gain slider. The "tag" value of the slider lets this
//    method distinguish between the two channels.
- (IBAction) mixerInputGainChanged: (UISlider *) sender {
    
    UInt32 inputBus = sender.tag;
    NSLog(@"Gain %lu Changed",inputBus);
    [audioObject setMixerInput: (UInt32) inputBus gain: (AudioUnitParameterValue) sender.value];
}

- (IBAction) playOrStop: (id) sender {
    
    if (audioObject.isPlaying) {
        
        [audioObject stopAUGraph];
        [self.playButton setTitle:@"START" forState:UIControlStateNormal];
        
    } else {
        
        [audioObject startAUGraph];
        [self.playButton setTitle:@"STOP" forState:UIControlStateNormal];
        NSThread* threadJawn = [[NSThread alloc] initWithTarget:self selector:@selector(beepMethod) object:nil];
        
        [threadJawn start];
    }
}

-(void)beepMethod
{
    int tempo = [tempoLabel.text integerValue];
    int uMin = 60000000;
    int sleepTime = uMin/tempo;
    while([audioObject isPlaying])
    {
        int twoCount = 0;
        int threeCount = 0;
        int fourCount = 0;
        int fadeFactor = 2;
        for(float i = 12; i>0; i--)
        {
            if(fmodf(i,12)==0)
            {
                float faderIntense = [mixerBus0LevelFader value];
                [[beepObjects objectAtIndex:0] makeBeep];
                double secs = 60.0/tempo/fadeFactor;
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[ledViews objectAtIndex:0] blink:secs withIntensity:faderIntense];
                });
             
                
            }
            if(fmodf(i,6)==0)
            {
                float faderIntense = [mixerBus1LevelFader value];
                [[beepObjects objectAtIndex:1] makeBeep];
                double secs = 60.0/tempo/2.0/fadeFactor;
                if(twoCount == 0)
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[ledViews objectAtIndex:1] blink:secs withIntensity:faderIntense];
                    });
                    twoCount++;
                }
                else
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[ledViews objectAtIndex:2] blink:secs withIntensity:faderIntense];
                    });
                    twoCount = 0;
                }
                
                
            }
            if(fmodf(i,4)==0)
            {
                float faderIntense = [mixerBus2LevelFader value];
                [[beepObjects objectAtIndex:2] makeBeep];
                double secs = 60.0/tempo/3.0/fadeFactor;
                if(threeCount == 0)
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[ledViews objectAtIndex:3] blink:secs withIntensity:faderIntense];
                    });
                    threeCount++;
                }
                else if(threeCount == 1)
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[ledViews objectAtIndex:4] blink:secs withIntensity:faderIntense];
                    });
                    threeCount++;
                }
                else
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[ledViews objectAtIndex:5] blink:secs withIntensity:faderIntense];
                    });
                    threeCount = 0;
                }

            }
            if(fmodf(i,3)==0)
            {
                float faderIntense = [mixerBus3LevelFader value];
                [[beepObjects objectAtIndex:3] makeBeep];
                double secs = 60.0/tempo/4.0/fadeFactor;
                if(fourCount == 0)
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[ledViews objectAtIndex:6] blink:secs withIntensity:faderIntense];
                    });
                    fourCount++;
                }
                else if(fourCount == 1)
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[ledViews objectAtIndex:7] blink:secs withIntensity:faderIntense];
                    });
                    fourCount++;
                }
                else if(fourCount == 2)
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[ledViews objectAtIndex:8] blink:secs withIntensity:faderIntense];
                    });
                    fourCount++;
                }
                else
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[ledViews objectAtIndex:9] blink:secs withIntensity:faderIntense];
                    });
                    fourCount = 0;
                }
            }
            usleep(sleepTime/12);
        }
       
    }
}



// Handle a change in playback state that resulted from an audio session interruption or end of interruption
- (void) handlePlaybackStateChanged: (id) notification {
    
    [self playOrStop: nil];
}

#pragma mark -
#pragma mark Mixer unit control

// Handle a Mixer unit input on/off switch action. The "tag" value of the switch lets this
//    method distinguish between the two channels.
- (IBAction) enableMixerInput: (UISwitch *) sender {
    
    UInt32 inputBus = sender.tag;
    AudioUnitParameterValue isOn = (AudioUnitParameterValue) sender.isOn;
    
    [audioObject enableMixerInput: inputBus isOn: isOn];
    
}


#pragma mark -
#pragma mark Remote-control event handling
// Respond to remote control events
- (void) remoteControlReceivedWithEvent: (UIEvent *) receivedEvent {
    
    if (receivedEvent.type == UIEventTypeRemoteControl) {
        
        switch (receivedEvent.subtype) {
                
            case UIEventSubtypeRemoteControlTogglePlayPause:
                [self playOrStop: nil];
                break;
                
            default:
                break;
        }
    }
}


#pragma mark -
#pragma mark Notification registration
// If this app's audio session is interrupted when playing audio, it needs to update its user interface
//    to reflect the fact that audio has stopped. The MixerHostAudio object conveys its change in state to
//    this object by way of a notification. To learn about notifications, see Notification Programming Topics.
- (void) registerForAudioObjectNotifications {
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    
    [notificationCenter addObserver: self
                           selector: @selector (handlePlaybackStateChanged:)
                               name: MixerHostAudioObjectPlaybackStateDidChangeNotification
                             object: audioObject];
}


#pragma mark -
#pragma mark Application state management



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    currentPreset = 1;
    tempProgramLabel.text = [NSString stringWithFormat:@"%d",currentPreset];
    
    int viewCount = 0;

    LedView* tempView;
    ledViews = [[NSMutableArray alloc] init];
    
    tempoLabel.multipleSwipe = true;
    tempoLabel.lowerBound = 40;
    tempoLabel.upperBound = 300;
    
    
    tempView = [[LedView alloc] initWithFrame:CGRectMake(10, 24, 300,25)];
    [tempView setBackgroundColor:[UIColor redColor]];
    [tempView turnOn];
    //[tempView setIntensity:1.0];
    //tempView.hidden = false;
    [ledViews addObject:tempView];
    [self.view addSubview:[ledViews objectAtIndex:viewCount]];
    viewCount++;
    
    int numLed = 2;
    int segmentSize = 300/numLed - 5 + 5/numLed;
    for(int i = 0; i<numLed; i++)
    {
        tempView = [[LedView alloc] initWithFrame:CGRectMake(10+i*segmentSize + i*5, 24+30*(numLed-1), 300/numLed-5,25)];
        
        [tempView setBackgroundColor:[UIColor redColor]];
        [tempView turnOn];
        //[tempView setIntensity:1.0];
        //tempView.hidden = false;
        [ledViews addObject:tempView];
        [self.view addSubview:[ledViews objectAtIndex:viewCount]];
        viewCount++;

    }
    
    numLed = 3;
    segmentSize = 300/numLed - 5 + 5/numLed;
    for(int i = 0; i<numLed; i++)
    {
        tempView = [[LedView alloc] initWithFrame:CGRectMake(10+i*segmentSize + i*5, 24+30*(numLed-1), 300/numLed-5,25)];
        
        [tempView setBackgroundColor:[UIColor redColor]];
        [tempView turnOn];
        //[tempView setIntensity:1.0];
        //tempView.hidden = false;
        [ledViews addObject:tempView];
        [self.view addSubview:[ledViews objectAtIndex:viewCount]];
        viewCount++;
        
    }
    
    
    numLed = 4;
    segmentSize = 300/numLed - 5 + 5/numLed;
    for(int i = 0; i<numLed; i++)
    {
        tempView = [[LedView alloc] initWithFrame:CGRectMake(10+i*segmentSize + i*5, 24+30*(numLed-1), 300/numLed-5,25)];
        
        [tempView setBackgroundColor:[UIColor redColor]];
        [tempView turnOn];
        //[tempView setIntensity:1.0];
        //tempView.hidden = false;
        [ledViews addObject:tempView];
        [self.view addSubview:[ledViews objectAtIndex:viewCount]];
        viewCount++;
        
    }

    beepObjects = [[NSMutableArray alloc] init];

    beepObj1 = [[BeepObject alloc] init];
    [beepObj1 initializeTrackWithSound:(NSString *)@"down"];
    [beepObjects addObject:beepObj1];
    
    beepObj2 = [[BeepObject alloc] init];
    [beepObj2 initializeTrackWithSound:(NSString *)@"sub"];
    [beepObjects addObject:beepObj2];
    
    beepObj3 = [[BeepObject alloc] init];
    [beepObj3 initializeTrackWithSound:(NSString *)@"sub"];
    [beepObjects addObject:beepObj3];
    
    beepObj4 = [[BeepObject alloc] init];
    [beepObj4 initializeTrackWithSound:(NSString *)@"sub"];
    [beepObjects addObject:beepObj4];
    
    MixerHostAudio *newAudioObject = [[MixerHostAudio alloc] initWithBusses:[beepObjects count] withBeepObjects:beepObjects];
    self.audioObject = newAudioObject;
    [self registerForAudioObjectNotifications];
    [self initializeMixerSettingsToUI];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)saveGesturePressed:(UILongPressGestureRecognizer *)recognizer
{
    if(recognizer.state != UIGestureRecognizerStateBegan)
        return;
    NSLog(@"Preset Saved");
    
}
- (IBAction)presetUpSwipe:(UISwipeGestureRecognizer *)recognizer
{
    NSLog(@"Preset Up");
    currentPreset++;
    if(currentPreset > totalPresets)
        currentPreset = totalPresets + 1;
    tempProgramLabel.text = [NSString stringWithFormat:@"%d",currentPreset];
}
- (IBAction)presetDownSwipe:(UISwipeGestureRecognizer *)recognizer
{
    NSLog(@"Preset Down");
    currentPreset--;
    if(currentPreset<1)
        currentPreset = 1;
    tempProgramLabel.text = [NSString stringWithFormat:@"%d",currentPreset];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)savePreset
{
    
}

-(void)loadPresets
{
    
}

@end
