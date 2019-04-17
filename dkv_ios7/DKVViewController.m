//
//  FirstViewController.m
//  DKV
//
//  Created by Jonas Berglund on 2013-04-08.
//  Copyright (c) 2013 Jonas Berglund. All rights reserved.
//

#import "DKVViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <Parse/Parse.h>
#define IMAGE_COUNT 26


@interface DKVViewController ()

@end

@implementation DKVViewController

- (void)viewDidLoad
{
    
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    soundFile = nil;
    
    
    
    [self tassarBackground];
    [self recivePush];

    
}

-(void)recivePush{
    NSString *appId = [Parse getApplicationId];
    NSLog(@"%@", appId);
}


-(void)tassarBackground{
    //array to hold images
    NSMutableArray *imageArray = [[NSMutableArray alloc]
                                  initWithCapacity:IMAGE_COUNT];
    // build an array
    int i;
    for(i=1; i<IMAGE_COUNT; i++)
        [imageArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"cerise%d.png", i]]];
    //animate
    _bg.animationImages = [NSArray arrayWithArray:imageArray];
    _bg.animationDuration=52;
       [_bg startAnimating];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)droopyButton:(id)sender {
    
    int randomNumber = arc4random() % 18 + 1;
    
    soundFile = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                        pathForResource:[NSString stringWithFormat:@"%02d", randomNumber] ofType:@"mp3"]];
    
    sound = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFile error:nil];
    sound.delegate = self;
    [sound play];
    
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}


@end
