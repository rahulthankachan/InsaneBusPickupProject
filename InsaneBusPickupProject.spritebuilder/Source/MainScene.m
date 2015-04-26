#import "MainScene.h"
#import "CapacityOfBus.h"

@implementation MainScene{
    
    CCButton *play;
    CCButton *about;
    CCButton *scores;
    CCButton *backbutton3;
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


- (void)backbutton3 {
    CCScene *mainscene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:mainscene];
    [[OALSimpleAudio sharedInstance] playEffect:buttonHitSoundEffect loop:NO];

}

-(void) didLoadFromCCB {
    //Sound effect of buttons
    buttonHitSoundEffect = @"boom-kick.wav";
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