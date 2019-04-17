//
//  SecondViewController.m
//  DKV
//
//  Created by Jonas Berglund on 2013-04-08.
//  Copyright (c) 2013 Jonas Berglund. All rights reserved.
//

#import "BandarnViewController.h"
#define IMAGE_COUNT 26
#define IMAGE_COUNT_NOTER 7



@interface BandarnViewController ()

@end

@implementation BandarnViewController
// ivar, initialized to UIBackgroundTaskInvalid in awakeFromNib
UIBackgroundTaskIdentifier bgTaskId;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self noterAnimation];
    [self tassarBackground];
    
    
   //self.view.backgroundColor = [UIColor underPageBackgroundColor];
    
    //[_textView setFont:[UIFont boldSystemFontOfSize:15]];
    
    [self.playButton setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    

    
    // Hittar musikfilen
    soundFile = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                        pathForResource:@"torsson"
                                        ofType:@"mp3"]];
    
    sound = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFile error:nil];
    sound.delegate = self;
    sound.numberOfLoops = -1;
    
    //self.textView.font = [UIFont fontWithName:@"Goudy Old Style" size:17];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [_bg startAnimating];
}

-(void)noterAnimation{
    //array to hold images
    NSMutableArray *imageArray = [[NSMutableArray alloc]
                                  initWithCapacity:IMAGE_COUNT_NOTER];
    // build an array
    int i;
    for(i=0; i<IMAGE_COUNT_NOTER; i++)
        [imageArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"not%d.png", i]]];
    //animate
    _noter.animationImages = [NSArray arrayWithArray:imageArray];
    _noter.animationDuration=4;
}

-(void)tassarBackground{
    //array to hold images
    NSMutableArray *imageArray = [[NSMutableArray alloc]
                                  initWithCapacity:IMAGE_COUNT];
    // build an array
    int i;
    for(i=1; i<IMAGE_COUNT; i++)
        [imageArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"blue%d.png", i]]];
    //animate
    _bg.animationImages = [NSArray arrayWithArray:imageArray];
    _bg.animationDuration=52;
    [_bg startAnimating];
        
}


- (IBAction)bandarnButton:(id)sender {
    
    //Play DKV
    
    if(!sound.playing){
        
        // Spelar upp musikfilen
        [sound play];
        
        [self.playButton setImage:[UIImage imageNamed:@"pause.png"] forState:UIControlStateNormal];
       
        [_noter startAnimating];
        
        if([sound play])
            bgTaskId = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:NULL];
        
        
    }
    else if(sound.playing){
        [sound stop];
        [self.playButton setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
        [_noter stopAnimating];
    }
    
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)success
{
    UIBackgroundTaskIdentifier newTaskId = UIBackgroundTaskInvalid;
    
    if (bgTaskId != UIBackgroundTaskInvalid) {
        [[UIApplication sharedApplication] endBackgroundTask: bgTaskId];
    }
    
    bgTaskId = newTaskId;
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}
@end
