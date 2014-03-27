//
//  AMBBeaconManager.m
//  iBeaconDemo
//
//  Created by Adam Bulmer on 25/03/2014.
//  Copyright (c) 2014 Adam Bulmer. All rights reserved.
//

#import "AMBBeaconManager.h"

@implementation AMBBeaconManager

-(id)init {
    
    self = [ super init ];
    
    if ( self ) {
        UUID = @"202C70B3-1072-42ED-B46F-A62796D4506E";
    }
    
    return self;
    
}

// Get the Apps Beacon UUID
-( NSUUID* )getUUID {
   return [ [ NSUUID alloc ] initWithUUIDString:UUID ];
}

// Get the Apps Beacon Region
-( CLBeaconRegion * )getBeaconRegion {
    
    return [ [ CLBeaconRegion alloc ] initWithProximityUUID:[self getUUID] identifier:@"com.adambulmer.test" ];
    
}


// transmit beacon action. call this to start transmitting.
-( void )transmitBeacon:( NSInteger )major minor:( NSInteger )minor {
    
    CLBeaconRegion *beaconRegion = [ [  CLBeaconRegion alloc ] initWithProximityUUID:[self getUUID] major:major minor:minor identifier:@"com.adambulmer.test" ];
    
    beaconPeripheralData = [ beaconRegion peripheralDataWithMeasuredPower:nil ];
    peripheralManager = [ [ CBPeripheralManager alloc ] initWithDelegate:self queue:nil options:nil ];
    
}

// Start advertising the beacon transmitter when the bluetooth io is ready.
-(void)peripheralManagerDidUpdateState:( CBPeripheralManager * )peripheral {
    
    if ( peripheral.state == CBPeripheralManagerStatePoweredOn ) {
        
        NSLog( @"Powered On" );
        [ peripheralManager startAdvertising:beaconPeripheralData ];
        
    } else if ( peripheral.state == CBPeripheralManagerStatePoweredOff ) {
        
        NSLog(@"Powered Off");
        [ peripheralManager stopAdvertising ];
        
    }
    
}

// Start monitoring for beacon.
-(void)findBeacon {
    
    locationManager = [ [ CLLocationManager alloc] init ];
    locationManager.delegate = self;
    
    [ locationManager startMonitoringForRegion:[self getBeaconRegion] ];
    
}

// Enter Beacon.
-(void)locationManager:( CLLocationManager *)manager didEnterRegion:( CLRegion * )region {
    
    [ locationManager startRangingBeaconsInRegion:[self getBeaconRegion] ];
    
}

// Exit beacon.
-(void)locationManager:( CLLocationManager *)manager didExitRegion:( CLRegion * )region {
    
    [ locationManager stopRangingBeaconsInRegion:[self getBeaconRegion] ];
    
}

// Do Stuff with the beacon.
-(void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region {
 
    CLBeacon *beacon = [ [ CLBeacon alloc ] init ];
    beacon = [ beacons lastObject ];
    
    NSString *beaconUUID = beacon.proximityUUID.UUIDString;
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
        
    }
    
}

@end
