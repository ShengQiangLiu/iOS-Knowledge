//
//  ViewController.m
//  KnowledgeTest
//
//  Created by Sniper on 16/3/6.
//  Copyright © 2016年 ShengQiang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)gcdBtnClick:(UIButton *)sender
{
    
    /*案例一*/
//    NSLog(@"1"); // 任务1
//    dispatch_sync(dispatch_get_main_queue(), ^{
//        NSLog(@"2"); // 任务2
//    });
//    NSLog(@"3"); // 任务3
    
    /*案例二，然而并不会死锁哦，主线程中执行一个并发队列*/
//    NSLog(@"1"); // 任务1
//    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//        NSLog(@"2"); // 任务2
//    });
//    NSLog(@"3"); // 任务3
    
    
    /*案例三*/
//    dispatch_queue_t queue = dispatch_queue_create("com.demo.serialQueue", DISPATCH_QUEUE_SERIAL);
//    NSLog(@"1"); // 任务1
//    dispatch_async(queue, ^{
//        NSLog(@"2"); // 任务2
//        dispatch_sync(queue, ^{
//            NSLog(@"3"); // 任务3
//        });
//        NSLog(@"4"); // 任务4
//    });
//    NSLog(@"5"); // 任务5
    
    /*案例四*/
//    NSLog(@"1"); // 任务1
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        NSLog(@"2"); // 任务2
//        dispatch_sync(dispatch_get_main_queue(), ^{
//            NSLog(@"3"); // 任务3
//        });
//        NSLog(@"4"); // 任务4
//    });
//    NSLog(@"5"); // 任务5
    
    /*案例五*/
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"1"); // 任务1
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"2"); // 任务2
        });
        NSLog(@"3"); // 任务3
    });
    NSLog(@"4"); // 任务4
    while (1) {
        
    }
    NSLog(@"5"); // 任务5
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
