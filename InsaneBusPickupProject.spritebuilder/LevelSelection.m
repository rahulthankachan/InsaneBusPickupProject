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
    BOOL _flag1;
    BOOL _flag2;
    BOOL _flag3;
    BOOL _flag4;
}

- (void) didLoadFromCCB {
    buttonHitSoundEffect = @"boom-kick.wav";
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSString *finalPath = [path stringByAppendingPathComponent:@"GameData.plist"];
    NSMutableDictionary *plistData = [NSMutableDictionary dictionaryWithContentsOfFile:finalPath];
    _flag1 = [[plistData objectForKey:@"level1Flag"] boolValue];
    _flag2 = [[plistData objectForKey:@"level2Flag"] boolValue];
    _flag3 = [[plistData objectForKey:@"level3Flag"] boolValue];
    _flag4 = [[plistData objectForKey:@"level4Flag"] boolValue];
}

- (void) btnBack {
    CCScene *mainscene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:mainscene];
    [[OALSimpleAudio sharedInstance] playEffect:buttonHitSoundEffect loop:NO];
}

- (void) btnLevel1 {
    if (_flag1 == YES) {
        CCScene *gameplay = [CCBReader loadAsScene:@"gameplay"];
        [[CCDirector sharedDirector] replaceScene:gameplay];
        [[OALSimpleAudio sharedInstance] playEffect:buttonHitSoundEffect loop:NO];

    }
}

- (void) btnLevel2 {
    if (_flag2 == YES) {
        CCScene *gameplay = [CCBReader loadAsScene:@"gameplay"];
        [[CCDirector sharedDirector] replaceScene:gameplay];
        [[OALSimpleAudio sharedInstance] playEffect:buttonHitSoundEffect loop:NO];
        
    }

}

- (void) btnLevel3 {
    if (_flag3 == YES) {
        CCScene *gameplay = [CCBReader loadAsScene:@"gameplay"];
        [[CCDirector sharedDirector] replaceScene:gameplay];
        [[OALSimpleAudio sharedInstance] playEffect:buttonHitSoundEffect loop:NO];
        
    }

}

- (void) btnLevel4 {
    if (_flag4 == YES) {
        CCScene *gameplay = [CCBReader loadAsScene:@"gameplay"];
        [[CCDirector sharedDirector] replaceScene:gameplay];
        [[OALSimpleAudio sharedInstance] playEffect:buttonHitSoundEffect loop:NO];
        
    }
}
@end
