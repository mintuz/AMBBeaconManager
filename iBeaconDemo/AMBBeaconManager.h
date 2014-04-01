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
    
    // Create an NSDictionary property which contains the peripheral data of the beacon
    NSDictionary *beaconPeripheralData;
    
    // CBPeripheralManager property where the methods are contained to start it transmitting
    CBPeripheralManager *peripheralManager;
    
    // Property which is unique to application
    NSString *UUID;
    
    // Allowing the beacons to be found
    CLLocationManager *locationManager;
    
}

-(id)initWithUUID:( NSString* )uuid;
-(void)setUUID:( NSString* )uuid;

-( NSUUID* )getUUID;
-( CLBeaconRegion * )getBeaconRegion;

-(void)transmitBeacon:( NSInteger )major minor:( NSInteger )minor;
-(void)findBeacon:( void (^)( id beacon ) )callback;

@end
