//
//  ViewController.m
//  AVAudioPlayerQueue
//
//  Created by CIA on 14/06/2018.
//  Copyright © 2018 CIA. All rights reserved.
//

#import "ViewController.h"
#import "AVAudioPlayerQueueManager.h"
@import AVFoundation;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
}

- (IBAction)playButtonPressed:(id)sender {
    NSArray *task1 = @[@"one.m4a",@"two.m4a",@"three.m4a",@"four.m4a",@"five.m4a",@"six.m4a"];
    
    NSMutableArray *task2 = [NSMutableArray new];
    for (int i = 1; i <= 6; i++) {
        NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%d.mp3",i] ofType:nil];
        NSData *data = [NSData dataWithContentsOfFile:path];
        if (data) {
            [task2 addObject:data];
        }
    }
    [[AVAudioPlayerQueueManager sharedInstance] enqueueBundleAudioFiles:task1 withTaskIdentifer:@"task1" beginPlayCallBack:^(NSString *taskID) {
        NSLog(@"%@：Start",taskID);
    } endPlayCallBack:^(NSString *taskID) {
        NSLog(@"%@：Finish",taskID);
    }];
    [[AVAudioPlayerQueueManager sharedInstance] enqueueAudioDatas:task2 withTaskIdentifer:@"task2" beginPlayCallBack:^(NSString *taskID) {
        NSLog(@"%@：Start",taskID);
    } endPlayCallBack:^(NSString *taskID) {
        NSLog(@"%@：Finish",taskID);
    }];
}
- (IBAction)cancelAllButtonPressed:(id)sender {
    [[AVAudioPlayerQueueManager sharedInstance] cancelAllTask];
}



@end
