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
    [ beaconManager setIdentifier:@"com.adam.test" ];
    
    [ beaconManager findBeacon:^( CLBeacon* beacon ) {
        
         /*NSString *beaconUUID = beacon.proximityUUID.UUIDString;
         NSString *beaconMajor = [ NSString stringWithFormat:@"%@", beacon.major ];
         NSString *beaconMinor = [ NSString stringWithFormat:@"%@", beacon.minor ];
         NSString *beaconAccuracy = [ NSString stringWithFormat:@"%f", beacon.accuracy ];
         NSString *beaconRSSI = [ NSString stringWithFormat:@"%i", beacon.rssi ];*/
         
         if ( beacon.proximity == CLProximityUnknown ) {

             beacon_close.text = @"Unknown";
         
         } else if ( beacon.proximity == CLProximityImmediate ) {

             beacon_close.text = @"Close";
         
         } else if ( beacon.proximity == CLProximityNear ) {

             beacon_close.text = @"Near";

         } else if ( beacon.proximity == CLProximityFar ) {

             beacon_close.text = @"Far";
             
         }
        
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
