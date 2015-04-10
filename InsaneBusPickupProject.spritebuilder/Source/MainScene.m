#import "MainScene.h"

@implementation MainScene{
    
    CCButton *play;
    
}

- (void)play {
    CCScene *gameplayscene = [CCBReader loadAsScene:@"gameplay"];
    [[CCDirector sharedDirector] replaceScene:gameplayscene];
}

@end