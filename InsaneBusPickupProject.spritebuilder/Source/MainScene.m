#import "MainScene.h"

@implementation MainScene{
    
    CCButton *play;
    CCButton *about;
    CCButton *scores;
    CCButton *backbutton2;
    CCButton *backbutton3;
    CCLabelTTF *scorelabel1;
    CCLabelTTF *scorelabel2;
    CCLabelTTF *scorelabel3;
    
    NSString *buttonHitSoundEffect;
}

- (void)play {
    CCScene *selection = [CCBReader loadAsScene:@"LevelSelection"];
    [[CCDirector sharedDirector] replaceScene:selection];
    [[OALSimpleAudio sharedInstance] playEffect:buttonHitSoundEffect loop:NO];
}

- (void)scores {
    CCScene *scorescene = [CCBReader loadAsScene:@"scorescene"];
    [[CCDirector sharedDirector] replaceScene:scorescene];
    [[OALSimpleAudio sharedInstance] playEffect:buttonHitSoundEffect loop:NO];

}

- (void)about {
    CCScene *aboutscene = [CCBReader loadAsScene:@"aboutscene"];
    [[CCDirector sharedDirector] replaceScene:aboutscene];
    [[OALSimpleAudio sharedInstance] playEffect:buttonHitSoundEffect loop:NO];

}

- (void)backbutton2 {
    CCScene *mainscene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:mainscene];
}
- (void)backbutton3 {
    CCScene *mainscene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:mainscene];
}

-(void) didLoadFromCCB {
    //Sound effect of buttons
    buttonHitSoundEffect = @"boom-kick.wav";
    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSString *finalPath = [path stringByAppendingPathComponent:@"GameData.plist"];
    NSMutableDictionary *plistData = [NSMutableDictionary dictionaryWithContentsOfFile:finalPath];
    h1 = [[plistData objectForKey:@"score1"] integerValue];
    h2 = [[plistData objectForKey:@"score2"] integerValue];
    h3 = [[plistData objectForKey:@"score3"] integerValue];
    NSLog(@"h1:%ld",h1);
    [scorelabel1 setString:[NSString stringWithFormat:@"HighScore1: %ld", h1]];
    [scorelabel2 setString:[NSString stringWithFormat:@"HighScore2: %ld", h2]];
    [scorelabel3 setString:[NSString stringWithFormat:@"HighScore3: %ld", h3]];
    [self preloadAndPlayMusic];

}

-(void) preloadAndPlayMusic
{
    // Preload...
    [[OALSimpleAudio sharedInstance] preloadBg:@"DesertRace_22050Hz_Loop.wav"];
    
    // Play (and loop the music)...
    [[OALSimpleAudio sharedInstance] playBgWithLoop:YES];
    
    // To stop the music...
    //[[OALSimpleAudio sharedInstance] stopBg];
    
    NSLog(@"Background music is playing.");
}

@end