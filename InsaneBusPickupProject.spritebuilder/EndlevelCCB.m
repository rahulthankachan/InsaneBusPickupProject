//
//  EndlevelCCB.m
//  InsaneBusPickupProject
//
//  Created by Rahul Thankachan on 4/22/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "EndlevelCCB.h"
#import "RetrieveScores.h"

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
    CCSprite *_trophy1shield;
    CCSprite *_trophy2health;
    CCSprite *_trophy3star;
    
}



-(void) didLoadFromCCB {
    
    self.userInteractionEnabled=true;
    _trophy3star.visible=FALSE;
    _trophy2health.visible=FALSE;
    _trophy1shield.visible=FALSE;
    NSInteger timeScore,studentScore,bonusScore,totalScore,timeRemaining,students,numberOfT;
    numberOfT=0;
    
    [_timeScore setString:@"Rahul"];
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSDictionary *dataForScoreScreen=[[NSDictionary alloc]initWithDictionary:[defaults objectForKey:@"dataForScoreScreen"]];
    

    
    
    timeRemaining=[[dataForScoreScreen objectForKey:@"distance"] integerValue];
    students=[[dataForScoreScreen objectForKey:@"students"] integerValue];
    NSArray *trophies= [[NSArray alloc]initWithArray:[dataForScoreScreen objectForKey:@"trophies"]];
    for(NSString *temp in trophies){
        if ([temp isEqual:@"health"]) {
            _trophy2health.visible=TRUE;
            numberOfT++;
        }
        else if ([temp isEqual:@"star"]){
        
            _trophy3star.visible=TRUE;
            numberOfT++;
        }
        else if ([temp isEqual:@"shield"]){
            
            _trophy1shield.visible=TRUE;
            numberOfT++;
        }
    
    }
    

    
    
    
    timeScore= timeRemaining*5;
    studentScore= students*20;
    bonusScore= numberOfT*50;
    
    [_timeRemaining setString:[NSString stringWithFormat:@"%i",timeRemaining]];
    [_students setString:[NSString stringWithFormat:@"%i",students]];
    [_timeScore setString:[NSString stringWithFormat:@"%i",timeScore]];
    [_studentScore setString:[NSString stringWithFormat:@"%i",studentScore]];
    [_bonusScore setString:[NSString stringWithFormat:@"%i",bonusScore]];
    [_totalScore setString:[NSString stringWithFormat:@"%i",studentScore+bonusScore+timeScore]];
    
    
    
    
#pragma mark Current Level Later to plist()

    NSMutableDictionary *currentUsedata= [[NSMutableDictionary alloc]initWithDictionary:[defaults objectForKey:@"currentUserData"]];
    NSInteger maxLevel= [[currentUsedata objectForKey:@"maxReachedLevel"] integerValue];
    NSInteger currentLevel= [[currentUsedata objectForKey:@"currentLevel"] integerValue];
    
    if(maxLevel<=currentLevel&&maxLevel<4){
        currentLevel++;
        [currentUsedata setValue:[NSNumber numberWithInt:currentLevel] forKey:@"maxReachedLevel"];
        [defaults setObject:currentUsedata forKey:@"currentUserData"];
    
    }
    
    
    RetrieveScores *retrieveScores = [[RetrieveScores alloc]init];
    [retrieveScores setScores:studentScore+bonusScore+timeScore andLevel:currentLevel];

    
    
    
    
    
    
    
    
    
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


#pragma mark handling the touch



-(void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event{
   CGPoint touchLocation = [touch locationInNode:self];
    
    NSLog(@"The x position is %f",touchLocation.x);
    NSLog(@"The y position is %f",touchLocation.y);
    
    
    if ((touchLocation.x+10>_restartButton.position.x&&touchLocation.x-10<_restartButton.position.x) && (touchLocation.y+10>_restartButton.position.y&&touchLocation.y-10<_restartButton.position.y)) {
        
        CCScene *selection = [CCBReader loadAsScene:@"gameplay"];
        [[CCDirector sharedDirector] replaceScene:selection];
       
    }
    
    if ((touchLocation.x+10>_menuButton.position.x&&touchLocation.x-10<_menuButton.position.x) && (touchLocation.y+10>_menuButton.position.y&&touchLocation.y-10<_menuButton.position.y)) {
        
        CCScene *selection = [CCBReader loadAsScene:@"MainScene"];
        [[CCDirector sharedDirector] replaceScene:selection];
        
    }
    
    if ((touchLocation.x+10>_nextButton.position.x&&touchLocation.x-10<_nextButton.position.x) && (touchLocation.y+10>_nextButton.position.y&&touchLocation.y-10<_nextButton.position.y)) {
        
        CCScene *selection = [CCBReader loadAsScene:@"LevelSelection"];
        [[CCDirector sharedDirector] replaceScene:selection];
        
    }


}


@end
