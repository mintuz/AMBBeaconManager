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
    [ beaconManager findBeacon:^( id beacon ) {
        
         /*NSString *beaconUUID = beacon.proximityUUID.UUIDString;
         NSString *beaconMajor = [ NSString stringWithFormat:@"%@", beacon.major ];
         NSString *beaconMinor = [ NSString stringWithFormat:@"%@", beacon.minor ];
         NSString *beaconAccuracy = [ NSString stringWithFormat:@"%f", beacon.accuracy ];
         NSString *beaconRSSI = [ NSString stringWithFormat:@"%i", beacon.rssi ];
         
         if ( beacon.proximity == CLProximityUnknown ) {
         
         // Unknown Proximity
         UIAlertView *alert = [[UIAlertView alloc]
         initWithTitle: @"Unknown"
         message: @""
         delegate: nil
         cancelButtonTitle:@"OK"
         otherButtonTitles:nil];
         [alert show];
         
         } else if ( beacon.proximity == CLProximityImmediate ) {
         
         // Close Proximity
         UIAlertView *alert = [[UIAlertView alloc]
         initWithTitle: @"Close"
         message: @""
         delegate: nil
         cancelButtonTitle:@"OK"
         otherButtonTitles:nil];
         [alert show];
         
         } else if ( beacon.proximity == CLProximityNear ) {
         
         // Near Proximity
         UIAlertView *alert = [[UIAlertView alloc]
         initWithTitle: @"Near"
         message: @""
         delegate: nil
         cancelButtonTitle:@"OK"
         otherButtonTitles:nil];
         [alert show];
         
         } else if ( beacon.proximity == CLProximityFar ) {
         
         // Far
         UIAlertView *alert = [[UIAlertView alloc]
         initWithTitle: @"Far"
         message: @""
         delegate: nil
         cancelButtonTitle:@"OK"
         otherButtonTitles:nil];
         [alert show];
         
         }*/
        
    } ];
    
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
    [ alert show ];
    
    [ beaconManager transmitBeacon:1 minor:[minor.text integerValue] ];
    
}

@end
