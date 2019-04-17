//
//  KlockaViewController.h
//  DKV
//
//  Created by Jonas Berglund on 2013-04-08.
//  Copyright (c) 2013 Jonas Berglund. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>
#import <AVFoundation/AVFoundation.h>


@interface KlockaViewController : UIViewController <UIAccelerometerDelegate, AVAudioPlayerDelegate>{
    NSDate *timerDate;
    NSUInteger time;
    NSUInteger beer;
    double sens;
    IBOutlet UISlider *slider;
    NSString *timeString;
    NSMutableArray *tider;
    NSInteger arrayIndex;
    NSUInteger antalBeer;
    BOOL ciderMode;
    
    NSURL *soundFile;
    AVAudioPlayer *sound;
}
@property (strong, nonatomic) IBOutlet UIImageView *pilarImage;
@property (strong, nonatomic) IBOutlet UILabel *supermodeLabel;
@property (strong, nonatomic) IBOutlet UILabel *stopwatchLabel;
@property (strong, nonatomic) IBOutlet UILabel *labelSens;
- (IBAction)onStartPressed:(id)sender;
- (IBAction)onStopPressed:(id)sender;
- (IBAction)onResetPressed:(id)sender;
- (IBAction)slider:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *tidStop;

@property (strong, nonatomic) IBOutlet UIImageView *bg;
@property (nonatomic, strong) UISwipeGestureRecognizer *leftSwipeGestureRecognizer;
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGestureRecognizer;
@property (strong, nonatomic) IBOutlet UIPageControl *tiderScroll;

@property (strong, nonatomic) IBOutlet UIImageView *beerImage;

- (IBAction)hsButton:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *hsImage;

@property(readonly, nonatomic) CMAcceleration acceleration;
@property (strong, nonatomic) CMMotionManager *motionManager;

@end
