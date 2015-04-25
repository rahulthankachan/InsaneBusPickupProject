//
//  ObjectOnRoad.h
//  InsaneBusPickupProject
//
//  Created by Yao Fan on 4/22/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "CCSprite.h"

@interface ObjectOnRoad : CCSprite
@property NSInteger type;
@property NSString *soundEffect;
- (id)initWithType:(NSInteger) type withCollisionType:(NSString *) collisionType andCollisionGroup:(NSString *) collisionGroup;


@end
