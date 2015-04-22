//
//  GameLevel.h
//  InsaneBusPickupProject
//
//  Created by Rahul Thankachan on 4/18/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameLevel : NSObject
{
   

}

@property (strong,atomic)GameLevel* currentGameLevel;
@property NSInteger maxDistance;
@property NSInteger maxStudents;
@property NSInteger maxCars;
@property NSInteger levelNumber;

+(GameLevel*)sendLevelObjectForLevel: (NSInteger) userLevel;
+(NSMutableArray*)sendPatternForLevel: (NSInteger) userLevel;

@end
