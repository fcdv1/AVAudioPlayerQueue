# AVAudioPlayerQueue
Use AVAudio Player to play audio
Several audio file is make a group, when this group of file begin play,or all play finished,
you can get callback

How to use?

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
