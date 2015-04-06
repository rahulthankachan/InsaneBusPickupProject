//
//  Header.h
//  InsaneBusPickupProject
//
//  Created by Yao Fan on 3/4/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#ifndef InsaneBusPickupProject_Header_h
#define InsaneBusPickupProject_Header_h

@interface GamePlayScene : CCNode <CCPhysicsCollisionDelegate>
{
    //Character *character;
    //CCPhysicsNode *physicsNode;
}

-(void) initialize;
//-(void) addObstacle;
//-(void) showScore;


- (void) updateScore: (int) currentScore;

@end

#endif
