//
//  GameFinScene.m
//  InsaneBusPickupProject
//
//  Created by WangWenqiang on 4/21/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "GameFinScene.h"

@implementation GameFinScene {
    CCLabelTTF *_label1;
    CCLabelTTF *_label2;
    CCLabelTTF *_label3;
}

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

- (NSInteger) calcScore:(NSInteger) stuNum TimeElpased:(NSInteger) timeUsed {
    return timeUsed/5*(stuNum+1);
    
}

-(void) didLoadFromCCB {
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSString *finalPath = [path stringByAppendingPathComponent:@"GameData.plist"];
    NSMutableDictionary *plistData = [NSMutableDictionary dictionaryWithContentsOfFile:finalPath];
    NSInteger nStu = [[plistData objectForKey:@"nStu"] integerValue];
    NSInteger tim = [[plistData objectForKey:@"timeUsed"] integerValue];

    NSLog(@"nStu:%ld",nStu);
    [_label1 setString:[NSString stringWithFormat:@"Students: %ld", nStu]];
    [_label2 setString:[NSString stringWithFormat:@"Time Used: %ld", tim]];
    NSInteger finalScore = [self calcScore:nStu TimeElpased:tim];
    [_label3 setString:[NSString stringWithFormat:@"Score: %ld", finalScore]];
}


@end
