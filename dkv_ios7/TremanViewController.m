//
//  TremanViewController.m
//  DKV
//
//  Created by Jonas Berglund on 2013-04-08.
//  Copyright (c) 2013 Jonas Berglund. All rights reserved.
//

#import "TremanViewController.h"
#define IMAGE_COUNT 26

@interface TremanViewController ()

@end

@implementation TremanViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    srand(time(NULL));
    rollState = 0;
    value1 = 1;
    value2 = 0;
    isChallange = false;
    klunkarTot = 0;
    klunkar = 0;
    
    // -----------------------------
	// One finger, one tap
	// -----------------------------
    
	// Create gesture recognizer, notice the selector method
    UITapGestureRecognizer *oneFingerOneTaps =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(oneFingerTwoTaps)];
    
    // Set required taps and number of touches
    [oneFingerOneTaps setNumberOfTapsRequired:1];
    [oneFingerOneTaps setNumberOfTouchesRequired:1];
    
    // Add the gesture to the view
    [[self view] addGestureRecognizer:oneFingerOneTaps];
    
    [self tassarBackground];
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    [self becomeFirstResponder];

}

- (void)viewDidDisappear:(BOOL)animated {
    
    [self becomeFirstResponder];

}



- (BOOL)canBecomeFirstResponder {
    return YES;
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

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    [self throwDice];
}

- (void)oneFingerTwoTaps
{
    [self throwDice];
}

-(void)throwDice{
    if(isChallange){
        if(value1 == 2)
            [self challange1];
        else
            [self challange2];
    }
    else if(rollState == 0)
        [self rolling];
}


- (IBAction)showRules:(id)sender {
    TremanReglerViewController * regler = [[TremanReglerViewController alloc] init];
    
    [self presentViewController:regler animated:YES completion:nil];
    
}


- (void)rolling{
    
    if(rollState < 6){
        rollState++;
        value1 = rand()%6 +1;
        value2 = rand()%6 +1;
        if(value1 == 1)
            self.diceImage1.image = [UIImage imageNamed:@"dicedkv.png"];
        else
            self.diceImage1.image = [UIImage imageNamed:[NSString stringWithFormat:@"dice%d.png",value1]];
        self.diceImage2.image = [UIImage imageNamed:[NSString stringWithFormat:@"dice%d.png",value2]];
        [self performSelector:@selector(rolling) withObject:nil afterDelay:0.1];
    }
    else{
        rollState = 0;
        value1 = rand()%6 +1;
        value2 = rand()%6 +1;

        if(value1 == 1){
            self.diceImage1.image = [UIImage imageNamed:@"dicedkv.png"];
        }
        else{
            self.diceImage1.image = [UIImage imageNamed:[NSString stringWithFormat:@"dice%d.png",value1]];
        }
        self.diceImage2.image = [UIImage imageNamed:[NSString stringWithFormat:@"dice%d.png",value2]];
        
        [self setLabel];
        
    }
    
}

-(void)challange1{
    

    if(rollState < 6){
        rollState++;
        value1 = rand()%6 +1;
        self.diceImage1.image = [UIImage imageNamed:[NSString stringWithFormat:@"dice%d.png",value1]];
        [self performSelector:@selector(challange1) withObject:nil afterDelay:0.1];
    }
    else{
        rollState = 0;
        value1 = rand()%6 +1;
        self.diceImage1.image = [UIImage imageNamed:[NSString stringWithFormat:@"dice%d.png",value1]];
        
        if(value1 != 1){
            if(value1 == 2)
                self.eventLabel.text = @"Drick 1 klunk!";
            else
                self.eventLabel.text = [NSString stringWithFormat:@"Drick %d klunkar!",value1 - 1];
            isChallange = false;
            klunkar = value1 - 1;
            [self updateKlunkar:klunkar];
        }
        else{
            self.eventLabel.text = @"Kasta igen!";
            if(value1 == 1){
                self.diceImage1.image = [UIImage imageNamed:@"dicedkvh.png"];
                self.diceImage2.image = [UIImage imageNamed:@"dice1.png"];
            }
            else{
                self.diceImage2.image = [UIImage imageNamed:@"dice1h.png"];
                self.diceImage1.image = [UIImage imageNamed:@"dicedkv.png"];
            }
        }
    }
}


-(void)challange2{
    
    
    if(rollState < 6){
        rollState++;
        value2 = rand()%6 +1;
        self.diceImage2.image = [UIImage imageNamed:[NSString stringWithFormat:@"dice%d.png",value2]];
        [self performSelector:@selector(challange2) withObject:nil afterDelay:0.1];
    }
    else{
        rollState = 0;
        value2 = rand()%6 +1;
        self.diceImage2.image = [UIImage imageNamed:[NSString stringWithFormat:@"dice%d.png",value2]];
        
        if(value2 != 1){
            if(value2 == 2)
                self.eventLabel.text = @"Drick 1 klunk!";
            else
                self.eventLabel.text = [NSString stringWithFormat:@"Drick %d klunkar!",value2 - 1];
            isChallange = false;
            klunkar = value2 - 1;
            [self updateKlunkar:klunkar];
        }
        else{
            self.eventLabel.text = @"Kasta igen!";
            value1 = 2;
            if(value1 == 1){
                self.diceImage1.image = [UIImage imageNamed:@"dicedkvh.png"];
                self.diceImage2.image = [UIImage imageNamed:@"dice1.png"];
            }
            else{
                self.diceImage2.image = [UIImage imageNamed:@"dice1h.png"];
                self.diceImage1.image = [UIImage imageNamed:@"dicedkv.png"];
            }
        }
    }
    
    
}

- (void)setLabel{
    
    switch (value1 + value2) {
        case 2:
            self.eventLabel.text = @"Självskål!";
            klunkar = 1;
            break;
            
        case 3:
            self.eventLabel.text = @"Utmaning!";
            isChallange = true;
            if(value1 == 1)
                self.diceImage1.image = [UIImage imageNamed:@"dicedkvh.png"];
            else
                self.diceImage2.image = [UIImage imageNamed:@"dice1h.png"];
            break;
            
        case 4:
            if(value1 == 2){
                self.eventLabel.text = @"Dela ut 4 klunkar!";
                klunkar = 4;
            }
            else{
                self.eventLabel.text = @"Treman!";
                klunkar = 1;
            }
            break;
            
        case 5:
            if (value1 == 1 || value2 == 1) {
                self.eventLabel.text = @"Finger på näsan!";
            }
            else
                self.eventLabel.text = @"Treman!";
            klunkar = 1;
            break;
            
        case 6:
            if (value1 == 3) {
                self.eventLabel.text = @"Dubbel treman, dela ut 6 klunkar!";
                klunkar = 8;
            }
            else
                self.eventLabel.text = @"Ingenting, nästas tur!";
            break;
            
        case 7:
            if ((value1 == 3) || (value2 == 3)) {
                self.eventLabel.text = @"Treman och seven ahead!";
                klunkar = 2;
            }
            else{
                self.eventLabel.text = @"Seven ahead!";
                klunkar = 1;
            }
            break;
            
        case 8:
            if ((value1 == 3) || (value2 == 3)) {
                self.eventLabel.text = @"Treman!";
                klunkar = 1;
            }
            else if ((value1 == 4) || (value2 == 4)) {
                self.eventLabel.text = @"Dela ut 8 klunkar!";
                klunkar = 8;
            }
            else
                self.eventLabel.text = @"Ingenting, nästas tur!";
            break;
            
            
        case 9:
            if ((value1 == 3) || (value2 == 3)) {
                self.eventLabel.text = @"Treman och nine behind!";
                klunkar = 2;
            }
            else
                self.eventLabel.text = @"Nine behind!";{
                    klunkar = 1;
                }
            break;
            
        case 10:
            if ((value1 == 5) || (value2 == 5)) {
                self.eventLabel.text = @"Dela ut 10 klunkar";
                klunkar = 10;
            }
            else
                self.eventLabel.text = @"Allmänskål!";
            break;
            
        case 12:
            self.eventLabel.text = @"Dela ut 12 klunkar!";
            klunkar = 12;
            break;
            
        default:
            self.eventLabel.text = @"Ingenting, nästas tur!";
            break;
    }
    
    [self updateKlunkar:klunkar];
    klunkar = 0;
    
}

-(void)updateKlunkar:(int)k{
    klunkarTot += k;
    self.klunkarLabel.text = [NSString stringWithFormat:@"Antal utdelade klunkar: %d",klunkarTot];
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

@end
