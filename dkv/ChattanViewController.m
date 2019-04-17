//
//  ChattanViewController.m
//  DKV
//
//  Created by Jonas Berglund on 2013-04-08.
//  Copyright (c) 2013 Jonas Berglund. All rights reserved.
//

#import "ChattanViewController.h"

@interface ChattanViewController ()

@end

@implementation ChattanViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    NSURL *chattanURL = [NSURL URLWithString:@"http://web.student.chalmers.se/~jonbergl/chattan/guestbook_iphone.php"];
    
    NSURLRequest *chattanRequest = [NSURLRequest requestWithURL:chattanURL];
    
    [chattan loadRequest:chattanRequest];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

@end
