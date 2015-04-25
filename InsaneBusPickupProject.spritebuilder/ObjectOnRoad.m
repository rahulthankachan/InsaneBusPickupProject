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
 type 8     timber
 */

- (id)initWithType:(NSInteger) type withCollisionType:(NSString *) collisionType andCollisionGroup:(NSString *) collisionGroup
{

        if (type == 1) {
            if (self) {
                self.type = 1;

            }
        } else if (type == 2) {
            if (self) {
                self.type = 2;

            }
        } else if (type == 3) {
            self = [super initWithImageNamed:@"road-barrier.png"];
            if (self) {
                self.type = 3;
                self.scale = 0.1;
                self.soundEffect = @"bomb.wav";
                self.physicsBody = [CCPhysicsBody bodyWithRect:CGRectMake(0, 0, self.contentSize.width, self.contentSize.height) cornerRadius:0];
                self.physicsBody.collisionType = collisionType;
                self.physicsBody.collisionGroup = collisionGroup;
            }
        } else if (type == 4) {
            if (self) {
                self.type = 4;

            }
        } else if (type == 5) {
            if (self) {
                self.type = 5;

            }
        } else if (type == 6) {
            self = [super initWithImageNamed:@"pizza.png"];
            if (self) {
                self.type = 6;
                self.scale = 0.06;
                self.soundEffect = @"power-up.wav";
                self.physicsBody = [CCPhysicsBody bodyWithRect:CGRectMake(0, 0, self.contentSize.width, self.contentSize.height) cornerRadius:0];
                self.physicsBody.collisionType = collisionType;
                self.physicsBody.collisionGroup = collisionGroup;

            }
        } else if (type == 7) {
            self = [super initWithImageNamed:@"gas-tank.png"];
            if (self) {
                self.type = 7;
                self.scale = 0.05;
                self.soundEffect = @"engine-start.wav";
                self.physicsBody = [CCPhysicsBody bodyWithRect:CGRectMake(0, 0, self.contentSize.width, self.contentSize.height) cornerRadius:0];
                self.physicsBody.collisionType = collisionType;
                self.physicsBody.collisionGroup = collisionGroup;
                

            }

        } else if (type == 8) {
            self = [super initWithImageNamed:@"timber.png"];
            if (self) {
                self.type = 8;
                self.scale = 0.12;
                self.soundEffect = @"wood-sword-fall.wav";
                self.physicsBody = [CCPhysicsBody bodyWithRect:CGRectMake(0, 0, self.contentSize.width, self.contentSize.height) cornerRadius:0];
                self.physicsBody.collisionType = collisionType;
                self.physicsBody.collisionGroup = collisionGroup;

            }
        }
    
    return self;
}

@end
