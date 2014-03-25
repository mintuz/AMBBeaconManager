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

// Setup the beacon region
-(void)setupBeaconRegion {
    
    NSUUID *uuid = [ [ NSUUID alloc ] initWithUUIDString:UUID ];
    beaconRegion = [ [ CLBeaconRegion alloc ] initWithProximityUUID:uuid
                                                                major:1
                                                                minor:1
                                                           identifier:@"com.adambulmer.test" ];
    
}


// transmit beacon action. call this to start transmitting.
-( void )transmitBeacon {
    
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
    
    // We create an NSUUID object. This string should match the one you created for the transmitter.
    NSUUID *uuid = [ [ NSUUID alloc ] initWithUUIDString:UUID ];
    beaconRegion = [ [ CLBeaconRegion alloc ] initWithProximityUUID:uuid identifier:@"com.adambulmer.test" ];
    
    [ locationManager startMonitoringForRegion:beaconRegion ];
    
}

// Enter Beacon.
-(void)locationManager:( CLLocationManager *)manager didEnterRegion:( CLRegion * )region {
    
    [ locationManager startRangingBeaconsInRegion:beaconRegion ];
    
}

// Exit beacon.
-(void)locationManager:( CLLocationManager *)manager didExitRegion:( CLRegion * )region {
    
    [ locationManager stopRangingBeaconsInRegion:beaconRegion ];
    
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
        
        NSLog( @"Unknown Proximity" );
        
    } else if ( beacon.proximity == CLProximityImmediate ) {
        
        NSLog( @"Immediate" );
        
    } else if ( beacon.proximity == CLProximityNear ) {
        
        NSLog( @"Near" );
        
    } else if ( beacon.proximity == CLProximityFar ) {
        
        NSLog( @"Far" );
        
    }
    
}

@end
