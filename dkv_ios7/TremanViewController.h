//
//  TremanViewController.h
//  DKV
//
//  Created by Jonas Berglund on 2013-04-08.
//  Copyright (c) 2013 Jonas Berglund. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "TremanReglerViewController.h"

@interface TremanViewController : UIViewController{
    int value1;
    int value2;
    int rollState;
    int klunkar;
    int klunkarTot;
    Boolean isChallange;
}

@property (weak, nonatomic) IBOutlet UILabel *eventLabel;
@property (weak, nonatomic) IBOutlet UIImageView *diceImage1;
@property (weak, nonatomic) IBOutlet UIImageView *diceImage2;
@property (strong, nonatomic) IBOutlet UILabel *klunkarLabel;
- (IBAction)showRules:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *bg;

- (void)rolling;

@end
