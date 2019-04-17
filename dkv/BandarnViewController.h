//
//  SecondViewController.h
//  DKV
//
//  Created by Jonas Berglund on 2013-04-08.
//  Copyright (c) 2013 Jonas Berglund. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface BandarnViewController : UIViewController<AVAudioPlayerDelegate>{
    
    NSURL *soundFile;
    AVAudioPlayer *sound;
    Boolean playing;
    IBOutlet UITextView *textView;
    
    
}
@property (strong, nonatomic) IBOutlet UIButton *playButton;
@property (retain, nonatomic) IBOutlet UIImageView *noter;
@property (strong, nonatomic) IBOutlet UIImageView *bg;

- (IBAction)bandarnButton:(id)sender;
//@property (strong, nonatomic) IBOutlet UITextView *textView;
@property(nonatomic, retain) UIFont *font;

@end
