#import "MainScene.h"

@implementation MainScene{
    
    CCButton *playButton;
    CCButton *scoresButton;
    CCButton *aboutButton;
    CCButton *backButton1;
    CCButton *backButton2;
    CCButton *backButton3;
    
}

- (void)playButton:(id)sender {
    CCScene *levels = [CCBReader loadAsScene:@"levels"];
    [[CCDirector sharedDirector] replaceScene:levels];
}
                       
- (void)aboutButton:(id)sender {
    CCScene *aboutscene = [CCBReader loadAsScene:@"aboutscene"];
    [[CCDirector sharedDirector] replaceScene:aboutscene];
}
                       
- (void)scoresButton:(id)sender {
    CCScene *scorescene = [CCBReader loadAsScene:@"scorescene"];
    [[CCDirector sharedDirector] replaceScene:scorescene];
}
                       
- (void)backbutton1:(id)sender {
    CCScene *MainScene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:MainScene];
}
                       
- (void)backbutton2:(id)sender {
    CCScene *MainScene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:MainScene];
}
                       
- (void)backbutton3:(id)sender {
    CCScene *MainScene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:MainScene];
}
                       
@end
