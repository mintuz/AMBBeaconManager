//
//  AMBViewController.m
//  iBeaconDemo
//
//  Created by Adam Bulmer on 25/03/2014.
//  Copyright (c) 2014 Adam Bulmer. All rights reserved.
//

#import "AMBViewController.h"

@interface AMBViewController ()

@end

@implementation AMBViewController

- (void)viewDidAppear:(BOOL)animated {
    
    [ super viewDidAppear:YES ];
	
    beaconManager = [ [ AMBBeaconManager alloc ] init ];
    [ beaconManager findBeacon ];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)transmit:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle: @"Transmitting"
                          message: @"Lets transmit a beacon"
                          delegate: nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil];
    [alert show];
    
    [ beaconManager transmitBeacon:1 minor:[minor.text integerValue] ];
    
}

@end
