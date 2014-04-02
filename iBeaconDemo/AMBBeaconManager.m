//
//  AMBBeaconManager.m
//  iBeaconDemo
//
//  Created by Adam Bulmer on 25/03/2014.
//  Copyright (c) 2014 Adam Bulmer. All rights reserved.
//

#import "AMBBeaconManager.h"

@implementation AMBBeaconManager

-( id )init {
    
    self = [ super init ];
    
    if ( self ) {
        _UUID = @"202C70B3-1072-42ED-B46F-A62796D4506E";
    }
    
    return self;
    
}

// Init the beacon manager with a UUID
-( id )initWithUUIDAndIdentifier:( NSString* )uuid identifier:( NSString * )identifier {
    
    self = [ super init ];
    
    if ( self ) {
        _UUID = uuid;
        _identifier = identifier;
    }
    
    return self;
    
}

// Set the Beacons UUID manually.
-( void )setUUID:( NSString* )uuid {
    _UUID = uuid;
}

-( void )setIdentifier:( NSString* )identifier {
    _identifier = identifier;
}

-( void )setMajor:( NSInteger )major {
    _major = major;
}

-( void )setMinor:( NSInteger )minor {
    _minor = minor;
}

// Get the Apps Beacon UUID
-( NSUUID* )getUUID {
   return [ [ NSUUID alloc ] initWithUUIDString:_UUID ];
}

// Get the Apps Beacon Region
-( CLBeaconRegion * )getBeaconRegion {
    return [ [ CLBeaconRegion alloc ] initWithProximityUUID:[ self getUUID ] identifier:_identifier ];
}

-( void )transmitBeacon {
    [ self transmitBeacon:_major minor:_minor ];
}

-( void )transmitBeacon:( NSInteger )major {
    [ self transmitBeacon:major minor:_minor ];
}

-( void )transmitBeacon:( NSInteger )major minor:( NSInteger )minor {
    
    CLBeaconRegion *beaconRegion = [ [  CLBeaconRegion alloc ] initWithProximityUUID:[ self getUUID ] major:major minor:minor identifier:_identifier ];
    
    beaconPeripheralData = [ beaconRegion peripheralDataWithMeasuredPower:nil ];
    peripheralManager = [ [ CBPeripheralManager alloc ] initWithDelegate:self queue:nil options:nil ];
    
}

// Start advertising the beacon transmitter when the bluetooth io is ready.
-(void)peripheralManagerDidUpdateState:( CBPeripheralManager * )peripheral {
    
    if ( peripheral.state == CBPeripheralManagerStatePoweredOn ) {
        [ peripheralManager startAdvertising:beaconPeripheralData ];
    } else if ( peripheral.state == CBPeripheralManagerStatePoweredOff ) {
        [ peripheralManager stopAdvertising ];
    }
    
}

// Start monitoring for beacon.
-(void)findBeacon:( void (^)( CLBeacon* beacon ) )callback {
    
    _callback = callback;
    
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
    
    _callback( beacon );
    
    
}

@end
