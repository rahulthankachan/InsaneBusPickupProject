#import "MainScene.h"

@implementation MainScene{
    
    CCButton *play;
    CCButton *scores;
    CCButton *about;
    CCButton *backbutton2;
    CCButton *backbutton3;
    
}

- (void)play {
    CCScene *gameplayscene = [CCBReader loadAsScene:@"gameplay"];
    [[CCDirector sharedDirector] replaceScene:gameplayscene];
}

- (void)scores {
    CCScene *scorescene = [CCBReader loadAsScene:@"scorescene"];
    [[CCDirector sharedDirector] replaceScene:scorescene];
}

- (void)about {
    CCScene *aboutscene = [CCBReader loadAsScene:@"aboutscene"];
    [[CCDirector sharedDirector] replaceScene:aboutscene];
}

- (void)backbutton2 {
    CCScene *mainscene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:mainscene];
}
- (void)backbutton3 {
    CCScene *mainscene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:mainscene];
}

@end