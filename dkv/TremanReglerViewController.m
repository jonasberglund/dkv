//
//  TremanReglerViewController.m
//  DKV
//
//  Created by Jonas Berglund on 2013-04-14.
//  Copyright (c) 2013 Jonas Berglund. All rights reserved.
//

#import "TremanReglerViewController.h"

@interface TremanReglerViewController ()

@end

@implementation TremanReglerViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismissViewController:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}
@end
