//
//  GameLevel.m
//  InsaneBusPickupProject
//
//  Created by Rahul Thankachan on 4/18/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "GameLevel.h"
#import "CrazyCarsTaxis.h"
#import "ObjectOnRoad.h"


static int x;
static GameLevel *currentLevel;
static NSMutableArray *patternA;

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
            currentLevel.maxStudents=25;
            currentLevel.maxDistance=1;
            currentLevel.levelNumber=userLevel;
            
            break;
            
        case 2:
            currentLevel.currentGameLevel=currentLevel;
            currentLevel.maxCars=5;
            currentLevel.maxStudents=10;
            currentLevel.maxDistance=1;
            currentLevel.levelNumber=userLevel;
            
            break;
            
        case 3:
            currentLevel.currentGameLevel=currentLevel;
            currentLevel.maxCars=8;
            currentLevel.maxStudents=15;
            currentLevel.maxDistance=20;
            currentLevel.levelNumber=userLevel;
            
            break;
            
        case 4:
            currentLevel.currentGameLevel=currentLevel;
            currentLevel.maxCars=12;
            currentLevel.maxStudents=20;
            currentLevel.maxDistance=25;
            currentLevel.levelNumber=userLevel;
            
            break;

            
        default:
            break;
    }
    
    return currentLevel;
}


+(NSMutableArray*)sendPatternForLevel: (NSInteger) userLevel{

    patternA= [[NSMutableArray alloc]init];
    
    
    CrazyCarsTaxis * newCar;
    

    NSInteger xcoord=180;
    for (int i=0; i<10; i++) {
        newCar= [[CrazyCarsTaxis alloc]initWithImageNamed:@"carimage.png"];
        newCar.physicsBody= [CCPhysicsBody bodyWithRect:CGRectMake(0, 0,newCar.contentSize.width, newCar.contentSize.height) cornerRadius:0];
        newCar.physicsBody.density=0.1;
        newCar.physicsBody.collisionGroup = @"notColliding";
        newCar.scale=0.3;
        newCar.position=ccp(xcoord,620+i*50);
        newCar.type=1;
        newCar.physicsBody.collisionType=@"level";
        [patternA addObject:newCar];
        
    }
    
    xcoord=180+100;

    for (int i=0; i<10; i++) {
        newCar= [[CrazyCarsTaxis alloc]initWithImageNamed:@"carimage.png"];
        newCar.physicsBody= [CCPhysicsBody bodyWithRect:CGRectMake(0, 0,newCar.contentSize.width, newCar.contentSize.height) cornerRadius:0];
        newCar.physicsBody.density=0.1;
        newCar.physicsBody.collisionGroup = @"notColliding";
        newCar.scale=0.3;
        newCar.position=ccp(xcoord,620+i*50);
        newCar.type=1;
        newCar.physicsBody.collisionType=@"level";
        [patternA addObject:newCar];
        
    }
    
    
    newCar= [[CrazyCarsTaxis alloc]initWithImageNamed:@"carimage.png"];
    newCar.physicsBody= [CCPhysicsBody bodyWithRect:CGRectMake(0, 0,newCar.contentSize.width, newCar.contentSize.height) cornerRadius:0];
    newCar.physicsBody.density=0.1;
    newCar.physicsBody.collisionGroup = @"notColliding";
    newCar.scale=0.3;
    newCar.position=ccp(xcoord+40-100,620+2*50);
    newCar.physicsBody.collisionType=@"level";
    newCar.type=1;
    
    [patternA addObject:newCar];

    
    return patternA;

}



@end


