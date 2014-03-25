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
    
    // This property is used to define the settings (proximityUUID, major and minor) used for transmitting.
    CLBeaconRegion *beaconRegion;
    
    // Create an NSDictionary property which contains the peripheral data of the beacon
    NSDictionary *beaconPeripheralData;
    
    // CBPeripheralManager property where the methods are contained to start it transmitting
    CBPeripheralManager *peripheralManager;
    
    // Property which is unique to application
    NSString *UUID;
    
    // Property that you use to specify a related set of beacons, in this case it will always be the same
    NSString *major;
    
    // Each beacon will have a different minor value.
    NSString *minor;
    
    // Define which beacons we are looking for
    CLBeaconRegion *LookForBeaconRegion;
    
    
    // Allowing the beacons to be found
    CLLocationManager *locationManager;
    
}

-(void)setupBeaconRegion;
-(void)transmitBeacon;
-(void)findBeacon;

@end
