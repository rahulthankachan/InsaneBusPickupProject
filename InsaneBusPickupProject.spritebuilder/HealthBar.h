#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface HealthBar: CCProgressNode;



-(id) initWithProgressTimerSprite:(CCSprite *)sprite;

-(void) update;

@property (nonatomic,retain) CCSprite *sprite;
@property (nonatomic,retain) CCProgressNode *progressTimer;

@end