//
//  AMBViewController.h
//  iBeaconDemo
//
//  Created by Adam Bulmer on 25/03/2014.
//  Copyright (c) 2014 Adam Bulmer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMBBeaconManager.h"

@interface AMBViewController : UIViewController {
    
    AMBBeaconManager *beaconManager;
    
    IBOutlet UILabel *in_region;
    IBOutlet UITextField *minor;
    
}

-(IBAction)transmit:(id)sender;

@end
