//
//  KlockaViewController.m
//  DKV
//
//  Created by Jonas Berglund on 2013-04-08.
//  Copyright (c) 2013 Jonas Berglund. All rights reserved.
//

#import "KlockaViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import <QuartzCore/QuartzCore.h>
#include<unistd.h>
#import <CoreMotion/CMAccelerometer.h>
#import <AVFoundation/AVFoundation.h>
#define IMAGE_COUNT 26
#define BEERIMAGES 8
#define CIDER 7

@interface KlockaViewController ()
@property (strong, nonatomic) NSTimer *stopWatchTimer; // Store the timer that fires after a certain time
@property (strong, nonatomic) NSDate *startDate; // Stores the date of the click on the start button
@property(nonatomic, copy) NSDictionary *titleTextAttributes;
@end


@implementation KlockaViewController

- (void)viewDidLoad
{
    [super viewDidLoad];


    
       //Accelerometer
    self.motionManager = [[CMMotionManager alloc] init];
    self.motionManager.accelerometerUpdateInterval = .001;
    [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue]
                                             withHandler:^(CMAccelerometerData  *accelerometerData, NSError *error) {
                                                 [self outputAccelertionData:accelerometerData.acceleration];
                                                 if(error){
                                                     
                                                     NSLog(@"%@", error);
                                                 }
                                             }];

    sens = slider.value;
    time = 0;
    beer = 0;
    
    ciderMode = false;
    
    //Swipe
    self.leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    self.rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    
    self.leftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    self.rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.view addGestureRecognizer:self.leftSwipeGestureRecognizer];
    [self.view addGestureRecognizer:self.rightSwipeGestureRecognizer];

    
    [self tassarBackground];
    
    
    antalBeer = 2;
    
    // -----------------------------
	// SUPERMODE
	// -----------------------------
    
	// Create gesture recognizer, notice the selector method
    UITapGestureRecognizer *hiddenBesk =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenBesk)];
    
    // Set required taps and number of touches
    [hiddenBesk setNumberOfTapsRequired:4];
    [hiddenBesk setNumberOfTouchesRequired:2];
    
    // Add the gesture to the view
    [[self view] addGestureRecognizer:hiddenBesk];
    

}

-(void)hiddenBesk{
    if(antalBeer == 2){
        self.supermodeLabel.hidden = NO;
        self.supermodeLabel.text = @"SUPERMODE";
        antalBeer = BEERIMAGES;
        if(beer != 0)
        self.pilarImage.image = [UIImage imageNamed:@"pilar1.png"];
    }
    else if(antalBeer != 2){
        antalBeer = 2;
        self.supermodeLabel.hidden = YES;
        
        beer = 0;
        self.beerImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"beer%d.png",beer]];
        
        self.pilarImage.image = [UIImage imageNamed:@"pilar0.png"];
        
        
    }
}


-(void)viewDidAppear:(BOOL)animated{
    [self resetTimer];
}

-(void)viewDidDisappear:(BOOL)animated{
    [self stopTimer];
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

-(void)ciderHafv{
    [self stopTimer];
    self.stopwatchLabel.text = @"XX.XXX";
    self.supermodeLabel.text = @"CIDERHÄFV!";
    AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
    //AudioServicesPlaySystemSound(1111);
    //AudioServicesPlaySystemSound(1110);
    ciderMode = true;
    
    soundFile = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                        pathForResource:[NSString stringWithFormat:@"%02d", 10] ofType:@"mp3"]];
    
    sound = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFile error:nil];
    sound.delegate = self;
    [sound play];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)outputAccelertionData:(CMAcceleration)acceleration
{
    if(fabs(acceleration.z) > sens){
        if (self.stopWatchTimer == nil){
            [self startTimer];
            
            if(beer == CIDER)
                [self ciderHafv];
            
        }
        //isValied gör att den bara tar en tid
        else if(time >= 2 && self.stopWatchTimer.isValid ){
            [self stopTimer];
        }
    }
}

// Create the stop watch timer that fires every 1 ms
-(void) createTimer {
    self.stopWatchTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/1000.0
                                                           target:self
                                                         selector:@selector(updateTimer)
                                                         userInfo:nil
                                                          repeats:YES];
}

-(void)startTimer{
    self.startDate = [NSDate date];
    if (self.stopWatchTimer == nil)
        [self createTimer];
    
    tider = [[NSMutableArray alloc] init];
    arrayIndex = -1;
    
    //AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
    //AudioServicesPlaySystemSound(1111);
    //AudioServicesPlaySystemSound(1110);
}

-(void)stopTimer{
    [self.stopWatchTimer invalidate];
    //AudioServicesPlaySystemSound(1111);
    //AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
    //if(tider != NULL)
      //  [self saveTime];
}

-(void)resetTimer{
    [self.stopWatchTimer invalidate];
    self.stopWatchTimer = nil;
    self.stopwatchLabel.text = @"00,000";
    time = 0;
    tider = NULL;
    self.tiderScroll.numberOfPages = 1;
}

- (IBAction)onStartPressed:(id)sender {
    [self startTimer];
}

- (IBAction)onStopPressed:(id)sender {
    
    if (self.stopWatchTimer != nil) {
        [self updateTimer];
        
    }
    [self stopTimer];
}

- (IBAction)onResetPressed:(id)sender {
    [self resetTimer];
    if(ciderMode){
        ciderMode = false;
        self.supermodeLabel.text = @"SUPERMODE";
    }
    
}

- (IBAction)slider:(id)sender {

    sens = slider.value;
    //self.labelSens.text = [NSString stringWithFormat:@"%1.5f",slider.value];
}

- (void)updateTimer
{
    // Create date from the elapsed time
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:self.startDate];
    timerDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    // Create a date formatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"ss,SSS"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    
    // Format the elapsed time and set it to the label
    timeString = [dateFormatter stringFromDate:timerDate];
    self.stopwatchLabel.text = timeString;
    
    // Update the time when acc can stop the timer
    time = (NSUInteger)[timerDate timeIntervalSince1970];

}

-(void)saveTime{
    [tider addObject:timeString];
    NSLog(@"tider: %@",tider);
    arrayIndex++;
    self.tiderScroll.numberOfPages = arrayIndex + 1;
    self.tiderScroll.currentPage = arrayIndex + 1;

}

- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    
    //if([tider count] != 0){
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromRight;
    
    CATransition *animation2 = [CATransition animation];
    animation2.duration = 0.5;
    animation2.type = kCATransitionPush;
    animation2.subtype = kCATransitionFromLeft;
    
    

    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        /*if(arrayIndex < [tider count] - 1){
            arrayIndex++;
            [self.stopwatchLabel.layer addAnimation:animation forKey:@"imageTransition"];
            self.stopwatchLabel.text = [tider objectAtIndex:arrayIndex];
            self.tiderScroll.currentPage = arrayIndex;
           
        }*/
        
        if(beer < antalBeer){
            beer++;
            [self.beerImage.layer addAnimation:animation forKey:@"imageTransition"];
            self.beerImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"beer%d.png",beer]];
            [self.pilarImage.layer addAnimation:animation forKey:@"imageTransition"];
        }
        
        
        if(beer == antalBeer)
            self.pilarImage.image = [UIImage imageNamed:@"pilar2.png"];
        else{
            
            self.pilarImage.image = [UIImage imageNamed:@"pilar1.png"];
        }
        
        
    }
    
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        
        if(beer > 0){
            beer--;
            [self.beerImage.layer addAnimation:animation2 forKey:@"imageTransition"];
            self.beerImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"beer%d.png",beer]];
            [self.pilarImage.layer addAnimation:animation2 forKey:@"imageTransition"];
        }
        
        
        if(beer == 0)
            self.pilarImage.image = [UIImage imageNamed:@"pilar0.png"];
        else{
            
            self.pilarImage.image = [UIImage imageNamed:@"pilar1.png"];
        }
    }
    
}


- (IBAction)hsButton:(id)sender {
    self.hsImage.hidden = !self.hsImage.hidden;
    //self.beerImage.hidden = !self.beerImage.hidden;
    if(self.hsImage.hidden)
        self.beerImage.alpha = 1;
    else
        self.beerImage.alpha = 0.1;
    
}
-(BOOL)prefersStatusBarHidden{
    return YES;
}
@end
