//
//  CapacityOfBus.m
//  InsaneBusPickupProject
//
//  Created by Yao Fan on 4/22/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "CapacityOfBus.h"

@implementation CapacityOfBus {



}

-(NSInteger) getCapacityOfBus {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ([defaults integerForKey:@"capacityOfBus"]) {
        NSInteger capacityOfBus = [defaults integerForKey:@"capacityOfBus"];
  
        //NSLog(@"The value of capacityOfBus is %ld", (long)[defaults integerForKey:@"capacityOfBus"]);
        return [defaults integerForKey:@"capacityOfBus"];
    } else {
        NSLog(@"Capacity of bus has not been asigned yet.");
        return -1;
    }
    
    
}

-(BOOL) increaseCapacityOfBusBy:(NSInteger) number {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ([defaults integerForKey:@"capacityOfBus"]) {
        NSInteger capacityOfBus = [defaults integerForKey:@"capacityOfBus"];
        capacityOfBus += number;
        [defaults setInteger:capacityOfBus forKey:@"capacityOfBus"];
        [defaults synchronize];
        //NSLog(@"The value of capacityOfBus is %ld", (long)[defaults integerForKey:@"capacityOfBus"]);
        return true;
    } else {
        NSLog(@"Capacity of bus has not been asigned yet.");
        return false;
    }
}

-(BOOL) initializeCapacityOfBus {
    NSInteger capacityOfBus = 5;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults integerForKey:@"capacityOfBus"]) {
        NSLog(@"Initilization of the capacity of the bus is not needed.");
        return false;
    } else {
        [defaults setInteger:capacityOfBus forKey:@"capacityOfBus"];
        [defaults synchronize];
        return true;
        
    }
}
@end
