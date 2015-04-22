//
//  LevelSelection.m
//  InsaneBusPickupProject
//
//  Created by WangWenqiang on 4/21/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "LevelSelection.h"

@implementation LevelSelection {
    NSString *buttonHitSoundEffect;
}

- (void) didLoadFromCCB {
    buttonHitSoundEffect = @"boom-kick.wav";
}

- (void) btnBack {
    CCScene *mainscene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:mainscene];
    [[OALSimpleAudio sharedInstance] playEffect:buttonHitSoundEffect loop:NO];
}

- (void) btnLevel1 {
    CCScene *gameplay = [CCBReader loadAsScene:@"gameplay"];
    [[CCDirector sharedDirector] replaceScene:gameplay];
    [[OALSimpleAudio sharedInstance] playEffect:buttonHitSoundEffect loop:NO];
}

- (void) btnLevel2 {
    CCScene *gameplay = [CCBReader loadAsScene:@"gameplay"];
    [[CCDirector sharedDirector] replaceScene:gameplay];
    [[OALSimpleAudio sharedInstance] playEffect:buttonHitSoundEffect loop:NO];
}

- (void) btnLevel3 {
    CCScene *gameplay = [CCBReader loadAsScene:@"gameplay"];
    [[CCDirector sharedDirector] replaceScene:gameplay];
    [[OALSimpleAudio sharedInstance] playEffect:buttonHitSoundEffect loop:NO];
}

- (void) btnLevel4 {
    CCScene *gameplay = [CCBReader loadAsScene:@"gameplay"];
    [[CCDirector sharedDirector] replaceScene:gameplay];
    [[OALSimpleAudio sharedInstance] playEffect:buttonHitSoundEffect loop:NO];
}
@end
