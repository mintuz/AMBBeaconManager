//
//  AMBBeaconManager.h
//  iBeaconDemo
//
//  Created by Adam Bulmer on 25/03/2014.
//  Copyright (c) 2014 Adam Bulmer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreLocation/CoreLocation.h>

@interface AMBBeaconManager : NSObject <CBPeripheralManagerDelegate, CLLocationManagerDelegate> {
    
    void (^_callback)(CLBeacon*);
    
    // Create an NSDictionary property which contains the peripheral data of the beacon
    NSDictionary *beaconPeripheralData;
    
    // CBPeripheralManager property where the methods are contained to start it transmitting
    CBPeripheralManager *peripheralManager;
    
    // Property which is unique to application
    NSString *_UUID;
    NSString *_identifier;
    NSInteger _major;
    NSInteger _minor;
    
    // Allowing the beacons to be found
    CLLocationManager *locationManager;
    
}

-( id )initWithUUIDAndIdentifier:( NSString* )uuid identifier:( NSString * )identifier;

-(void)setUUID:( NSString* )uuid;
-(void)setIdentifier:( NSString* )identifier;
-(void)setMajor:( NSInteger )major;
-(void)setMinor:( NSInteger )minor;

-( NSUUID* )getUUID;
-( CLBeaconRegion * )getBeaconRegion;

-(void)transmitBeacon;
-(void)transmitBeacon:( NSInteger )major;
-(void)transmitBeacon:( NSInteger )major minor:( NSInteger )minor;

-(void)findBeacon:( void (^)( CLBeacon* beacon ) )callback;

@end
