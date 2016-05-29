//
//  ViewController.m
//  RunLoop
//
//  Created by wangjin on 16/4/28.
//  Copyright © 2016年 wangjin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
<<<<<<< HEAD
    
    //github
=======
    //git
>>>>>>> frist
    
    ///runloop的由来，为什么使用？以及何时被创建？//////
    
    
    ///////--------------runloop的获取及使用--------------////////
    //注意主线程中runloop默认开启，子线程中runloop默认是关闭的（在讲子线程时会讲runloop的搭配使用）
    
    // 获取主线程的RunLoop对象
    CFRunLoopGetMain();
    // 获取当前线程的RunLoop对象
    CFRunLoopGetCurrent();

    // RunLoop的获取
    CFRunLoopRef cfLoop1 = CFRunLoopGetCurrent();
    CFRunLoopRef cfLoop2 = CFRunLoopGetMain();
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    NSRunLoop *mainLoop = [NSRunLoop mainRunLoop];
    
//     都是同一个RunLoop对象
        NSLog(@"-------%p",runLoop);
        NSLog(@"-------%p",mainLoop);
        NSLog(@"-------%p",cfLoop1);
        NSLog(@"-------%p",cfLoop2);

    //////runloop的mode类型///////
    /* 1. NSRunLoopModeRef
     * 通过制定RunLoopMode我们可以决定在什么地方执行什么任务
     */

    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(1000, 1000);
    [self.view addSubview:scrollView];

    // 默认是 DefaultMode
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];

    //我们发现，在我们滚动ScrollView执行ScrollView的代理方法时，timer方法不会得到执行，通过指定Timer在RunLoop中执行的Mode我们可以使Timer方法得到执行，避免了ScrollView滚定事件与timer事件之间的相互影响。
    NSRunLoop *loop = [NSRunLoop currentRunLoop];// 获取当前线程的runLoop
    [loop addTimer:timer forMode:NSRunLoopCommonModes];// 向RunLoop添加事件源并设置mode为common，

    // 获取当前RunLoop执行的事件Mode
    NSLog(@"%@",[loop currentMode]);//UIInitializationRunLoopMode，系统未开放的Mode


    // CADisplayLink 的使用
    //    CADisplayLink *ca = [CADisplayLink displayLinkWithTarget:self selector:@selector(timerAction)];
    //    ca.frameInterval = 60;//跳帧数
    //    [ca addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];

}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSLog(@"%@",[[NSRunLoop currentRunLoop] currentMode]);//UITrackingRunLoopMode，监听运动事件
    NSLog(@"is main thread %d",[NSThread isMainThread]);
}

- (void)timerAction {
    
    //    NSLog(@"%@",[[NSRunLoop currentRunLoop] currentMode]);//kCFRunLoopDefaultMode，默认的Mode
    
    NSLog(@"_______\ntimer run in main thread %d",[NSThread isMainThread]);
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
