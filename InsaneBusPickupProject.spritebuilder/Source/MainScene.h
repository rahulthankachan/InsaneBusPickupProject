#import "GamePlayScene.h"
#import <CoreMotion/CoreMotion.h>

int score;
int distance;
int count;

@interface MainScene : CCNode{

    CMMotionManager *motionManager;
    NSOperationQueue *operationQueue;
    NSTimer *timer;
    CCLabelTTF *label;
    CCLabelTTF *label2;

}

@end
