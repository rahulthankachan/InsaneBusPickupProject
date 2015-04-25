#import "MainScene.h"
#import "CapacityOfBus.h"

@implementation MainScene{
    
    CCButton *play;
    CCButton *about;
    CCButton *scores;
    CCButton *backbutton2;
    CCButton *backbutton3;
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
    [[OALSimpleAudio sharedInstance] playEffect:buttonHitSoundEffect loop:NO];

}
- (void)backbutton3 {
    CCScene *mainscene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:mainscene];
    [[OALSimpleAudio sharedInstance] playEffect:buttonHitSoundEffect loop:NO];

}

-(void) didLoadFromCCB {
    //Sound effect of buttons
    buttonHitSoundEffect = @"boom-kick.wav";
    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSString *finalPath = [path stringByAppendingPathComponent:@"GameData.plist"];
    NSMutableDictionary *plistData = [NSMutableDictionary dictionaryWithContentsOfFile:finalPath];
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
    [self preloadAndPlayMusic];
    NSLog(@"The value of capacity of bus is %ld", (long)[[CapacityOfBus alloc] getCapacityOfBus]);

}



-(void) preloadAndPlayMusic
{
//    // Preload...
//    [[OALSimpleAudio sharedInstance] preloadBg:@"DesertRace_22050Hz_Loop.wav"];
//    
//    // Play (and loop the music)...
//    [[OALSimpleAudio sharedInstance] playBgWithLoop:YES];
//    
//    // To stop the music...
//    //[[OALSimpleAudio sharedInstance] stopBg];
//    
//    NSLog(@"Background music is playing.");
}

@end