//
//  EightBitRanViewController.m
//  8BitRan
//
//  Created by Ran Tao on 10.3.12.
//  Copyright (c) 2012 Ran Tao. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "EightBitRanViewController.h"

@interface EightBitRanViewController ()
@property (nonatomic, strong) NSMutableArray *eightBitSamples;
@property (nonatomic, strong) NSTimer *soundTimer;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer;
@property (strong, nonatomic) UILabel *bitLabel;
@end

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@implementation EightBitRanViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.eightBitSamples = [NSMutableArray new];
        for (int i = 0; i < 45; i++) {
            [self.eightBitSamples addObject:[NSString stringWithFormat:@"sfx%d",i]];
        }
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.bitLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 30, self.view.frame.size.width - 60.0, self.view.frame.size.height - 60.0)];
   self.bitLabel.font = [UIFont fontWithName:@"04b03" size:100];
   self.bitLabel.backgroundColor = [UIColor clearColor];
   self.bitLabel.textAlignment = UITextAlignmentCenter;
   self.bitLabel.text = @"8bit";
   self.bitLabel.textColor = UIColorFromRGB(0xD93670);
    [self.view addSubview:self.bitLabel];

    self.soundTimer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(playRandomSample) userInfo:nil repeats:YES]; 
}

-(void) playRandomSample {
   self.bitLabel.textColor = [self randomColor];
    NSString *music = [[NSBundle mainBundle] pathForResource:[self.eightBitSamples objectAtIndex:arc4random() %45] ofType:@"wav"];
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:music] error:NULL];
    [self.audioPlayer prepareToPlay];
    [self.audioPlayer play];
}


-(float) randomHighIntensity {
    //return arc4random() % 11 * 0.1;
    // limit intensity to be very low
    return 1-arc4random() % 11 * 0.05;
}

- (UIColor*) randomColor {
    return [UIColor colorWithRed:[self randomHighIntensity] green:[self randomHighIntensity]  blue:[self randomHighIntensity]  alpha:1];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
