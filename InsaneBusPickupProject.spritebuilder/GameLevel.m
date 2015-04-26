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
            currentLevel.maxStudents=10;
            currentLevel.maxDistance=30;
            currentLevel.levelNumber=currentLevelNumber;
            
            break;
            
        case 2:
            currentLevel.currentGameLevel=currentLevel;
            currentLevel.maxCars=5;
            currentLevel.maxStudents=10;
            currentLevel.maxDistance=30;
            currentLevel.levelNumber=currentLevelNumber;
            
            break;
            
        case 3:
            currentLevel.currentGameLevel=currentLevel;
            currentLevel.maxCars=8;
            currentLevel.maxStudents=10;
            currentLevel.maxDistance=30;
            currentLevel.levelNumber=currentLevelNumber;
            
            break;
            
        case 4:
            currentLevel.currentGameLevel=currentLevel;
            currentLevel.maxCars=12;
            currentLevel.maxStudents=10;
            currentLevel.maxDistance=30;
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
        
        
        NSInteger xcoord=80;
        for (int i=0; i<20; i++) {
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
        
        xcoord=230;
        
        for (int i=0; i<15; i++) {
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
        newCar.position=ccp(xcoord-60,620+2*50);
        newCar.physicsBody.collisionType=@"level";
        newCar.type=1;
        [patternA addObject:newCar];
        
        newCar= [[CrazyCarsTaxis alloc]initWithImageNamed:@"carimage.png"];
        newCar.physicsBody= [CCPhysicsBody bodyWithRect:CGRectMake(0, 0,newCar.contentSize.width, newCar.contentSize.height) cornerRadius:0];
        newCar.physicsBody.density=0.1;
        newCar.physicsBody.collisionGroup = @"notColliding";
        newCar.scale=0.3;
        newCar.position=ccp(xcoord-60,620+4*50);
        newCar.physicsBody.collisionType=@"level";
        newCar.type=1;
        
        [patternA addObject:newCar];

        
        newCar= [[CrazyCarsTaxis alloc]initWithImageNamed:@"carimage.png"];
        newCar.physicsBody= [CCPhysicsBody bodyWithRect:CGRectMake(0, 0,newCar.contentSize.width, newCar.contentSize.height) cornerRadius:0];
        newCar.physicsBody.density=0.1;
        newCar.physicsBody.collisionGroup = @"notColliding";
        newCar.scale=0.3;
        newCar.position=ccp(xcoord-100,620+10*50);
        newCar.physicsBody.collisionType=@"level";
        newCar.type=1;
        
        
        [patternA addObject:newCar];
        
        ObjectOnRoad *powerUp = [[ObjectOnRoad alloc] initWithType:10 withCollisionType:@"objectOnRoad" andCollisionGroup:@"notColliding"];
       
        powerUp.position = ccp(xcoord-100+40, 620+12*50);
        [patternA addObject:powerUp];
        
        
    } else if (userLevel == 2) {
 
        CrazyCarsTaxis * newCar;
        
        
        NSInteger xcoord=180;
        
        
        xcoord=120;
        
        for (int i=0; i<7; i++) {
            newCar= [[CrazyCarsTaxis alloc]initWithImageNamed:@"carimage.png"];
            newCar.physicsBody= [CCPhysicsBody bodyWithRect:CGRectMake(0, 0,newCar.contentSize.width, newCar.contentSize.height) cornerRadius:0];
            newCar.physicsBody.density=0.1;
            newCar.physicsBody.collisionGroup = @"notColliding";
            newCar.scale=0.3;
            if (i%2 == 1) {
                newCar.position=ccp(xcoord + 40,520+i*50);
                
            } else {
                newCar.position=ccp(xcoord,520+i*50);
                
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
            if (i%3 == 0) {
                newCar.position=ccp(xcoord + 40,920+i*50 + 20);
                
            } else if (i%3 == 1) {
                newCar.position=ccp(xcoord,920+i*50);
                
            } else {
                newCar.position=ccp(xcoord - 40,920+i*50 - 20);

            }
            newCar.type=1;
            newCar.physicsBody.collisionType=@"level";
            [patternA addObject:newCar];
            
        }
        
        ObjectOnRoad *powerUp = [[ObjectOnRoad alloc] initWithType:10 withCollisionType:@"objectOnRoad" andCollisionGroup:@"notColliding"];
        
        powerUp.position = ccp(xcoord-100+40, 620+12*50);
        [patternA addObject:powerUp];
        
        ObjectOnRoad *grenade = [[ObjectOnRoad alloc] initWithType:9 withCollisionType:@"objectOnRoad" andCollisionGroup:@"notColliding"];
        grenade.position = ccp(xcoord - 100 + 70, 620 + 12 * 50 - 30);
        [patternA addObject:grenade];
        
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
                newCar.position=ccp(xcoord + 30,1120+i*50*1.2);

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
        int heightOffset = 50;
        for (int i=0; i<25; i++) {
            newCar= [[CrazyCarsTaxis alloc]initWithImageNamed:@"carimage.png"];
            newCar.physicsBody= [CCPhysicsBody bodyWithRect:CGRectMake(0, 0,newCar.contentSize.width, newCar.contentSize.height) cornerRadius:0];
            newCar.physicsBody.density=0.1;
            newCar.physicsBody.collisionGroup = @"notColliding";
            newCar.scale=0.3;
            if (i%3 == 0) {
                newCar.position=ccp(xcoord - 30,1020+i*50 + (i/3 * heightOffset));
                
            } else if (i%3 == 1) {
                newCar.position=ccp(xcoord,1020+i*50 + (i/3 * heightOffset));
                
            } else {
                newCar.position=ccp(xcoord + 30,1020+i*50 + (i/3 * heightOffset));

            }
            newCar.type=1;
            newCar.physicsBody.collisionType=@"level";
            [patternA addObject:newCar];
            
        }
        ObjectOnRoad *gas = [[ObjectOnRoad alloc] initWithType:7 withCollisionType:@"objectOnRoad" andCollisionGroup:@"notColliding"];
        gas.position = ccp(xcoord - 100 + 70, 620 + 12 * 50 - 30);
        [patternA addObject:gas];
        
        ObjectOnRoad *gas2 = [[ObjectOnRoad alloc] initWithType:7 withCollisionType:@"objectOnRoad" andCollisionGroup:@"notColliding"];
        gas2.position = ccp(xcoord + 70, 620 + 12 * 50 + 80);
        [patternA addObject:gas2];
        
        ObjectOnRoad *grenade = [[ObjectOnRoad alloc] initWithType:9 withCollisionType:@"objectOnRoad" andCollisionGroup:@"notColliding"];
        grenade.position = ccp(xcoord + 20, 620 + 12 * 50 + 80 - 100);
        [patternA addObject:grenade];
        
        ObjectOnRoad *diamond = [[ObjectOnRoad alloc] initWithType:11 withCollisionType:@"objectOnRoad" andCollisionGroup:@"notColliding"];
        diamond.position = ccp(xcoord + 20, 620 + 12 * 50 + 80 + 300);
        [patternA addObject:diamond];
        
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
        
        ObjectOnRoad *gas = [[ObjectOnRoad alloc] initWithType:7 withCollisionType:@"objectOnRoad" andCollisionGroup:@"notColliding"];
        gas.position = ccp(xcoord - 100 + 70, 620 + 4 * 50 - 30);
        [patternA addObject:gas];
        
        ObjectOnRoad *gas2 = [[ObjectOnRoad alloc] initWithType:7 withCollisionType:@"objectOnRoad" andCollisionGroup:@"notColliding"];
        gas2.position = ccp(xcoord - 180, 620 + 4 * 50 + 80);
        [patternA addObject:gas2];
        
        ObjectOnRoad *grenade = [[ObjectOnRoad alloc] initWithType:9 withCollisionType:@"objectOnRoad" andCollisionGroup:@"notColliding"];
        grenade.position = ccp(xcoord - 200, 620 + 4 * 50 + 80 - 100);
        [patternA addObject:grenade];
        
        ObjectOnRoad *diamond = [[ObjectOnRoad alloc] initWithType:11 withCollisionType:@"objectOnRoad" andCollisionGroup:@"notColliding"];
        diamond.position = ccp(xcoord + 20, 620 + 12 * 50 + 80 + 300);
        [patternA addObject:diamond];
        
    } else {
        
    }
   
return patternA;
}



@end


