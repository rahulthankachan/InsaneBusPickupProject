//
//  ObjectOnRoad.m
//  InsaneBusPickupProject
//
//  Created by Yao Fan on 4/22/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "ObjectOnRoad.h"

@implementation ObjectOnRoad
/*
 type 1     trophy
 type 2     horizontal bus
 type 3     road barrier
 type 4     construction area
 type 5     flame
 type 6     pizza
 type 7     gas refill
 */

- (id)initWithType:(NSInteger) type
{

        if (type == 1) {
            self = [super initWithImageNamed:nil];
            if (self) {
                self.type = 1;

            }
        } else if (type == 2) {
            self = [super initWithImageNamed:nil];
            if (self) {
                self.type = 2;

            }
        } else if (type == 3) {
            self = [super initWithImageNamed:nil];
            if (self) {
                self.type = 3;

            }
        } else if (type == 4) {
            self = [super initWithImageNamed:nil];
            if (self) {
                self.type = 4;

            }
        } else if (type == 5) {
            self = [super initWithImageNamed:nil];
            if (self) {
                self.type = 5;

            }
        } else if (type == 6) {
            self = [super initWithImageNamed:nil];
            if (self) {
                self.type = 6;

            }
        } else if (type == 7) {
            self = [super initWithImageNamed:@"gas-tank.png"];
            if (self) {
                self.type = 7;
                self.scale = 0.05;
                self.physicsBody = [CCPhysicsBody bodyWithRect:CGRectMake(0, 0, self.contentSize.width, self.contentSize.height) cornerRadius:0];
                self.physicsBody.collisionType = @"objectOnRoad";
                self.physicsBody.collisionGroup = @"notColliding";
                

            }

        } else if (type == 8) {
            self = [super initWithImageNamed:nil];
            if (self) {
                self.type = 8;

            }
        }
    
    return self;
}

@end
