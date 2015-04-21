//
//  GameFinScene.m
//  InsaneBusPickupProject
//
//  Created by WangWenqiang on 4/21/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "GameFinScene.h"

@implementation GameFinScene

- (void) btnNext {
    CCScene *nextlevel = [CCBReader loadAsScene:@"gameplay"];
    [[CCDirector sharedDirector] replaceScene:nextlevel];
}

- (void) btnMenu {
    CCScene *mainscene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:mainscene];
}

- (void) btnRetry {
    CCScene *retryscene = [CCBReader loadAsScene:@"gameplay"];
    [[CCDirector sharedDirector] replaceScene:retryscene];
}
@end
