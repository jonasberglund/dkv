//
//  FirstViewController.h
//  DKV
//
//  Created by Jonas Berglund on 2013-04-08.
//  Copyright (c) 2013 Jonas Berglund. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface DKVViewController : UIViewController<AVAudioPlayerDelegate> {
    NSURL *soundFile;
    AVAudioPlayer *sound;
    UIImageView *droopyImage;
}
@property (retain, nonatomic) IBOutlet UIImageView *bg;
- (IBAction)droopyButton:(id)sender;

@end
