//
//  scorescene.m
//  InsaneBusPickupProject
//
//  Created by Student on 4/26/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "scorescene.h"

@implementation scorescene {
    CCButton *backbutton2;
    NSString *buttonHitSoundEffect;
    CCLabelTTF *scorelabel1;
    CCLabelTTF *scorelabel2;
    CCLabelTTF *scorelabel3;
    CCLabelTTF *scorelabel4;
    CCLabelTTF *scorelabel5;
    CCLabelTTF *scorelabel6;
    CCLabelTTF *scorelabel7;
    CCLabelTTF *scorelabel8;
    CCLabelTTF *scorelabel9;
    CCLabelTTF *scorelabel10;
    CCLabelTTF *scorelabel11;
    CCLabelTTF *scorelabel12;
}

- (void)backbutton2 {
    CCScene *mainscene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:mainscene];
    [[OALSimpleAudio sharedInstance] playEffect:buttonHitSoundEffect loop:NO];
    
}


- (NSString *)docsDir {
    
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    
}

- (void)didLoadFromCCB {
     buttonHitSoundEffect = @"boom-kick.wav";
    NSString *listPath;
    NSMutableDictionary *plistData;
    listPath = [[self docsDir]stringByAppendingPathComponent:@"GameData.plist"];
    if(![[NSFileManager defaultManager]fileExistsAtPath:listPath]) {
        [[NSFileManager defaultManager]copyItemAtPath:[[NSBundle mainBundle]pathForResource:@"GameData" ofType:@"plist"] toPath:listPath error:nil];
    }
    plistData = [NSMutableDictionary dictionaryWithContentsOfFile:listPath];
    h[0] = [[plistData objectForKey:@"score1"] integerValue];
    h[1] = [[plistData objectForKey:@"score2"] integerValue];
    h[2] = [[plistData objectForKey:@"score3"] integerValue];
    h[3] = [[plistData objectForKey:@"score4"] integerValue];
    h[4] = [[plistData objectForKey:@"score5"] integerValue];
    h[5] = [[plistData objectForKey:@"score6"] integerValue];
    h[6] = [[plistData objectForKey:@"score7"] integerValue];
    h[7] = [[plistData objectForKey:@"score8"] integerValue];
    h[8] = [[plistData objectForKey:@"score9"] integerValue];
    h[9] = [[plistData objectForKey:@"score10"] integerValue];
    h[10] = [[plistData objectForKey:@"score11"] integerValue];
    h[11] = [[plistData objectForKey:@"score12"] integerValue];
    
    //  NSLog(@"h1:%ld",h1);
    [scorelabel1 setString:[NSString stringWithFormat:@"HighScore1: %ld", h[0]]];
    [scorelabel2 setString:[NSString stringWithFormat:@"HighScore2: %ld", h[1]]];
    [scorelabel3 setString:[NSString stringWithFormat:@"HighScore3: %ld", h[2]]];
    [scorelabel4 setString:[NSString stringWithFormat:@"HighScore1: %ld", h[3]]];
    [scorelabel5 setString:[NSString stringWithFormat:@"HighScore2: %ld", h[4]]];
    [scorelabel6 setString:[NSString stringWithFormat:@"HighScore3: %ld", h[5]]];
    [scorelabel7 setString:[NSString stringWithFormat:@"HighScore1: %ld", h[6]]];
    [scorelabel8 setString:[NSString stringWithFormat:@"HighScore2: %ld", h[7]]];
    [scorelabel9 setString:[NSString stringWithFormat:@"HighScore3: %ld", h[8]]];
    [scorelabel10 setString:[NSString stringWithFormat:@"HighScore1: %ld", h[9]]];
    [scorelabel11 setString:[NSString stringWithFormat:@"HighScore2: %ld", h[10]]];
    [scorelabel12 setString:[NSString stringWithFormat:@"HighScore3: %ld", h[11]]];
}

@end


