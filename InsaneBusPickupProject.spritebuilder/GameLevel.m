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



//static int x;
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
    
    
    NSUserDefaults *defaults= [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *currentUsedata= [[NSMutableDictionary alloc]initWithDictionary:[defaults objectForKey:@"currentUserData"]];
    
    //NSInteger maxLevel= [[currentUsedata objectForKey:@"maxReachedLevel"] integerValue];
    NSInteger currentLevelNumber= [[currentUsedata objectForKey:@"currentLevel"] integerValue];
    userLevel=currentLevelNumber;
    
    
    
    switch (currentLevelNumber) {
        case 1:
            currentLevel.currentGameLevel=currentLevel;
            currentLevel.maxCars=2;
            currentLevel.maxStudents=25;
            currentLevel.maxDistance=20;
            currentLevel.levelNumber=currentLevelNumber;
            
            break;
            
        case 2:
            currentLevel.currentGameLevel=currentLevel;
            currentLevel.maxCars=5;
            currentLevel.maxStudents=10;
            currentLevel.maxDistance=20;
            currentLevel.levelNumber=currentLevelNumber;
            
            break;
            
        case 3:
            currentLevel.currentGameLevel=currentLevel;
            currentLevel.maxCars=8;
            currentLevel.maxStudents=15;
            currentLevel.maxDistance=20;
            currentLevel.levelNumber=currentLevelNumber;
            
            break;
            
        case 4:
            currentLevel.currentGameLevel=currentLevel;
            currentLevel.maxCars=12;
            currentLevel.maxStudents=20;
            currentLevel.maxDistance=25;
            currentLevel.levelNumber=currentLevelNumber;
            
            break;

            
        default:
            break;
    }
    
    return currentLevel;
}


+(NSMutableArray*)sendPatternForLevel: (NSInteger) userLevel{
    
    patternA= [[NSMutableArray alloc]init];

    if (userLevel == 1) {
        
        
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
        
        
    } else if (userLevel == 2) {
 
        CrazyCarsTaxis * newCar;
        
        
        NSInteger xcoord=180;
        
        
        xcoord=120;
        
        for (int i=0; i<10; i++) {
            newCar= [[CrazyCarsTaxis alloc]initWithImageNamed:@"carimage.png"];
            newCar.physicsBody= [CCPhysicsBody bodyWithRect:CGRectMake(0, 0,newCar.contentSize.width, newCar.contentSize.height) cornerRadius:0];
            newCar.physicsBody.density=0.1;
            newCar.physicsBody.collisionGroup = @"notColliding";
            newCar.scale=0.3;
            if (i%2 == 1) {
                newCar.position=ccp(xcoord + 40,920+i*50);
                
            } else {
                newCar.position=ccp(xcoord,920+i*50);
                
            }
            newCar.type=1;
            newCar.physicsBody.collisionType=@"level";
            [patternA addObject:newCar];
            
        }
        
    } else if (userLevel == 3) {
        CrazyCarsTaxis * newCar;
        
        
        NSInteger xcoord=180;
        
        
        xcoord=120;
        
        for (int i=0; i<10; i++) {
            newCar= [[CrazyCarsTaxis alloc]initWithImageNamed:@"carimage.png"];
            newCar.physicsBody= [CCPhysicsBody bodyWithRect:CGRectMake(0, 0,newCar.contentSize.width, newCar.contentSize.height) cornerRadius:0];
            newCar.physicsBody.density=0.1;
            newCar.physicsBody.collisionGroup = @"notColliding";
            newCar.scale=0.3;
            if (i%2 == 1) {
                newCar.position=ccp(xcoord + 40,1120+i*50*1.2);

            } else {
                newCar.position=ccp(xcoord,1120+i*50);

            }
            newCar.type=1;
            newCar.physicsBody.collisionType=@"level";
            [patternA addObject:newCar];
            
        }
        
        for (int i=0; i<10; i++) {
            newCar= [[CrazyCarsTaxis alloc]initWithImageNamed:@"carimage.png"];
            newCar.physicsBody= [CCPhysicsBody bodyWithRect:CGRectMake(0, 0,newCar.contentSize.width, newCar.contentSize.height) cornerRadius:0];
            newCar.physicsBody.density=0.1;
            newCar.physicsBody.collisionGroup = @"notColliding";
            newCar.scale=0.3;
            if (i%2 == 1) {
                newCar.position=ccp(xcoord + 40,620+i*50);
                
            } else {
                newCar.position=ccp(xcoord,620+i*50);
                
            }
            newCar.type=1;
            newCar.physicsBody.collisionType=@"level";
            [patternA addObject:newCar];
            
        }
        
        
    } else if (userLevel == 4) {
        
        
        CrazyCarsTaxis * newCar;
        
        
        NSInteger xcoord=180;
        
        
        xcoord=120;
        
        for (int i=0; i<10; i++) {
            newCar= [[CrazyCarsTaxis alloc]initWithImageNamed:@"carimage.png"];
            newCar.physicsBody= [CCPhysicsBody bodyWithRect:CGRectMake(0, 0,newCar.contentSize.width, newCar.contentSize.height) cornerRadius:0];
            newCar.physicsBody.density=0.1;
            newCar.physicsBody.collisionGroup = @"notColliding";
            newCar.scale=0.3;
            newCar.position=ccp(xcoord,920+i*50);
            newCar.type=1;
            newCar.physicsBody.collisionType=@"level";
            [patternA addObject:newCar];
            
        }
        
        xcoord = 100;
        
        for (int i = 0; i < 7; ++i) {
            newCar= [[CrazyCarsTaxis alloc]initWithImageNamed:@"carimage.png"];
            newCar.physicsBody= [CCPhysicsBody bodyWithRect:CGRectMake(0, 0,newCar.contentSize.width, newCar.contentSize.height) cornerRadius:0];
            newCar.physicsBody.density=0.1;
            newCar.physicsBody.collisionGroup = @"notColliding";
            newCar.scale=0.3;
            newCar.position=ccp(xcoord + i * 40,620+i*50);
            newCar.physicsBody.collisionType=@"level";
            newCar.type=1;
            
            [patternA addObject:newCar];
        }
        
        xcoord = 300;
        
        for (int i = 0; i < 7; ++i) {
            newCar= [[CrazyCarsTaxis alloc]initWithImageNamed:@"carimage.png"];
            newCar.physicsBody= [CCPhysicsBody bodyWithRect:CGRectMake(0, 0,newCar.contentSize.width, newCar.contentSize.height) cornerRadius:0];
            newCar.physicsBody.density=0.1;
            newCar.physicsBody.collisionGroup = @"notColliding";
            newCar.scale=0.3;
            newCar.position=ccp(xcoord - i * 40,1220+i*50);
            newCar.physicsBody.collisionType=@"level";
            newCar.type=1;
            
            [patternA addObject:newCar];
        }
        
    } else {
        
    }
   
return patternA;
}



@end


