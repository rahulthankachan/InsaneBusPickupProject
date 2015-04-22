//
//  EndlevelCCB.m
//  InsaneBusPickupProject
//
//  Created by Rahul Thankachan on 4/22/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "EndlevelCCB.h"

@implementation EndlevelCCB{
    
    CCLabelTTF *_timeScore;
    CCLabelTTF *_studentScore;
    CCLabelTTF *_bonusScore;
    CCLabelTTF *_totalScore;
    CCLabelTTF *_timeRemaining;
    CCLabelTTF *_students;
    CCSprite *_trophy1;
    CCSprite *_trophy2;
    CCSprite *_trophy3;
    CCSprite *_restartButton;
    CCSprite *_menuButton;
    CCSprite *_nextButton;
    
}



-(void) didLoadFromCCB {
    
    [_timeScore setString:@"Rahul"];
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSDictionary *dataForScoreScreen=[[NSDictionary alloc]initWithDictionary:[defaults objectForKey:@"dataForScoreScreen"]];
    NSInteger timeScore,studentScore,bonusScore,totalScore,timeRemaining,students,numberOfT;
    timeRemaining=[[dataForScoreScreen objectForKey:@"distance"] integerValue];
    students=[[dataForScoreScreen objectForKey:@"students"] integerValue];
    numberOfT=[[dataForScoreScreen objectForKey:@"numberOfTrophies"] integerValue];
    
    
    timeScore= timeRemaining*5;
    studentScore= students*20;
    bonusScore= numberOfT*10;
    
    [_timeRemaining setString:[NSString stringWithFormat:@"%i",timeRemaining]];
    [_students setString:[NSString stringWithFormat:@"%i",students]];
    [_timeScore setString:[NSString stringWithFormat:@"%i",timeScore]];
    [_studentScore setString:[NSString stringWithFormat:@"%i",studentScore]];
    [_bonusScore setString:[NSString stringWithFormat:@"%i",bonusScore]];
    [_totalScore setString:[NSString stringWithFormat:@"%i",studentScore+bonusScore+timeScore]];
    
    
    
    
    
}

 

-(id)init {
    
    if (self = [super init]) {
        
        
    }

    
    if(self != nil)
    {
        // set this so we can register with touch dispatcher
        
    }
    
    return self;
    
}



@end
