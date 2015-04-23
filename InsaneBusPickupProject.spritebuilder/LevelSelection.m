//
//  LevelSelection.m
//  InsaneBusPickupProject
//
//  Created by WangWenqiang on 4/21/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "LevelSelection.h"
#import "AppDelegate.h"

@implementation LevelSelection {
    NSString *buttonHitSoundEffect;
    BOOL _flag1;
    BOOL _flag2;
    BOOL _flag3;
    BOOL _flag4;
    NSInteger currentLevel;
    NSUserDefaults *defaults;
    NSMutableDictionary *currentUsedata;
    CCSprite *_level2Lock;
    CCSprite *_level3Lock;
    CCSprite *_level4Lock;
    
    //CCAppDelegate *_appDelegate;
}

- (void) didLoadFromCCB {
    
//    NSUserDefaults *defaults= [NSUserDefaults standardUserDefaults];
//    NSMutableDictionary *setstate= [[NSMutableDictionary alloc]init];
//    setstate = [defaults objectForKey:@"userState"];
//    
//    
    

    
    defaults= [NSUserDefaults standardUserDefaults];
    currentUsedata= [[NSMutableDictionary alloc]initWithDictionary:[defaults objectForKey:@"currentUserData"]];
    
    NSInteger maxLevel= [[currentUsedata objectForKey:@"maxReachedLevel"] integerValue];
    currentLevel= [[currentUsedata objectForKey:@"currentLevel"] integerValue];
    

    
    if (!currentLevel) {
        currentLevel=1;
        maxLevel=1;
        [currentUsedata setValue:[NSNumber numberWithInt:currentLevel] forKey:@"currentLevel"];
        [currentUsedata setValue:[NSNumber numberWithInt:maxLevel] forKey:@"maxReachedLevel"];
        [defaults setObject:currentUsedata forKey:@"currentUserData"];
    }

    

    
    
    buttonHitSoundEffect = @"boom-kick.wav";
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSString *finalPath = [path stringByAppendingPathComponent:@"GameData.plist"];
    NSMutableDictionary *plistData = [NSMutableDictionary dictionaryWithContentsOfFile:finalPath];
//    _flag1 = [[plistData objectForKey:@"level1Flag"] boolValue];
//    _flag2 = [[plistData objectForKey:@"level2Flag"] boolValue];
//    _flag3 = [[plistData objectForKey:@"level3Flag"] boolValue];
//    _flag4 = [[plistData objectForKey:@"level4Flag"] boolValue];
    
    
    
    
    
    switch (maxLevel) {
        case 1:
            _flag1=true;
            
            break;
        case 2:
            [_level2Lock setVisible:FALSE];
            _flag1=true;
            _flag2=true;
            break;
            
        case 3:
            [_level3Lock setVisible:FALSE];
            _flag1=true;
            _flag2=true;
            _flag3=true;
        
            break;
        case 4:
            [_level4Lock setVisible:FALSE];
            _flag1=true;
            _flag2=true;
            _flag3=true;
            _flag4=true;
            break;
            
        default:
            break;
    }

    
}

- (void) btnBack {
    CCScene *mainscene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:mainscene];
    [[OALSimpleAudio sharedInstance] playEffect:buttonHitSoundEffect loop:NO];
    
}

- (void) btnLevel1 {
    if (_flag1 == YES) {
        

        [self setLevelto:1];
        
        
        
        CCScene *gameplay = [CCBReader loadAsScene:@"gameplay"];
        [[CCDirector sharedDirector] replaceScene:gameplay];
        [[OALSimpleAudio sharedInstance] playEffect:buttonHitSoundEffect loop:NO];
        //AppController* app = (AppController *)[UIApplication sharedApplication];
        //app.levelSelected = 1;
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:1] forKey:@"levelSelected"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void) btnLevel2 {
    if (_flag2 == YES) {
        
        [self setLevelto:2];
        
        
        CCScene *gameplay = [CCBReader loadAsScene:@"gameplay"];
        [[CCDirector sharedDirector] replaceScene:gameplay];
        [[OALSimpleAudio sharedInstance] playEffect:buttonHitSoundEffect loop:NO];
        //AppController* app = (AppController *)[UIApplication sharedApplication];
        //app.levelSelected = 2;
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:2] forKey:@"levelSelected"];
        [[NSUserDefaults standardUserDefaults] synchronize];

    }

}

- (void) btnLevel3 {
    if (_flag3 == YES) {
        
        [self setLevelto:3];
        CCScene *gameplay = [CCBReader loadAsScene:@"gameplay"];
        [[CCDirector sharedDirector] replaceScene:gameplay];
        [[OALSimpleAudio sharedInstance] playEffect:buttonHitSoundEffect loop:NO];
        //AppController* app = (AppController *)[UIApplication sharedApplication];
        //app.levelSelected = 3;
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:3] forKey:@"levelSelected"];
        [[NSUserDefaults standardUserDefaults] synchronize];

    }

}

- (void) btnLevel4 {
    
    if (_flag4 == YES) {
        
        [self setLevelto:4];
        CCScene *gameplay = [CCBReader loadAsScene:@"gameplay"];
        [[CCDirector sharedDirector] replaceScene:gameplay];
        [[OALSimpleAudio sharedInstance] playEffect:buttonHitSoundEffect loop:NO];
        //AppController* app = (AppController *)[UIApplication sharedApplication];
        //app.levelSelected = 4;
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:4] forKey:@"levelSelected"];
        [[NSUserDefaults standardUserDefaults] synchronize];

    }
}


-(void)setLevelto:(NSInteger) current{
    
    currentLevel=current;
    [currentUsedata setValue:[NSNumber numberWithInt:currentLevel] forKey:@"currentLevel"];
    [defaults setObject:currentUsedata forKey:@"currentUserData"];
    


}


@end
