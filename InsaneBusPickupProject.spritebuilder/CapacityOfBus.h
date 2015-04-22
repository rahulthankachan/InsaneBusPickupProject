//
//  CapacityOfBus.h
//  InsaneBusPickupProject
//
//  Created by Yao Fan on 4/22/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CapacityOfBus : NSObject {


}


-(NSInteger) getCapacityOfBus;
-(BOOL) increaseCapacityOfBusBy:(NSInteger) number;
-(BOOL) initializeCapacityOfBus;

@end
