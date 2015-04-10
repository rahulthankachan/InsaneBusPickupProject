//
//  Header.h
//  InsaneBusPickupProject
//
//  Created by Yao Fan on 4/5/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#ifndef InsaneBusPickupProject_Header_h
#define InsaneBusPickupProject_Header_h

@interface HudLayer : CCLayer
{
    CCSprite* joypad,*joybtn,
    CGPoint touchPos;
    float joybtnDistSquared,joybtnAngle;
    BOOL isMovingJoybtn;
}

#endif
