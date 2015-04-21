//
//  GameLevel.m
//  InsaneBusPickupProject
//
//  Created by Rahul Thankachan on 4/18/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "GameLevel.h"


static int x;
static GameLevel *currentLevel;

@implementation GameLevel
{

}
@synthesize currentGameLevel,maxCars,maxDistance,maxStudents;



+(void)initialize{

    currentLevel= [[GameLevel alloc]init];
}

+(GameLevel*)sendLevelObjectForLevel: (NSInteger) userLevel{
    
    switch (userLevel) {
        case 1:
            currentLevel.currentGameLevel=currentLevel;
            currentLevel.maxCars=2;
            currentLevel.maxStudents=5;
            currentLevel.maxDistance=1;
            currentLevel.levelNumber=userLevel;
            
            break;
            
        case 4:
            currentLevel.currentGameLevel=currentLevel;
            currentLevel.maxCars=4;
            currentLevel.maxStudents=10;
            currentLevel.maxDistance=1;
            currentLevel.levelNumber=userLevel;
            
            break;

            
        default:
            break;
    }
    
    return currentLevel;
}



@end


