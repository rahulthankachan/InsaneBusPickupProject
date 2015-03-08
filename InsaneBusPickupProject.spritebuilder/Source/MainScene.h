#import "GamePlayScene.h"
#import <CoreMotion/CoreMotion.h>

@interface MainScene : CCNode{

    CMMotionManager *motionManager;
    NSOperationQueue *operationQueue;
    NSTimer *timer;
    CCLabelTTF *label;
    CCLabelTTF *label2;

}

@end
