#import "GamePlayScene.h"
#import <CoreMotion/CoreMotion.h>
#import "GameLevel.h"
#import "AppDelegate.h"

long score;
int distance;
int count;

@interface gameplay : CCNode<CCPhysicsCollisionDelegate>
{
    
    CMMotionManager *motionManager;
    NSOperationQueue *operationQueue;
    NSTimer *timer;
    CCLabelTTF *label;
    CCLabelTTF *label2;
    
}

@end