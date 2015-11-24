//
//  ViewController.m
//  iOS Runtime Sample Code
//
//  Created by Tim.Z on 11/24/15.
//  Copyright © 2015 Tim.Z. All rights reserved.
//

#import "ViewController.h"
#import "TZPerson.h"

    // 使用运行时的第一步:导入<objc/message.h>
    // 第二步:Build Setting -> 搜索msg -> 设置属性为No
#import <objc/message.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


    //通过objc_msgSend发送消息
- (IBAction)sendMsg:(id)sender
{
    TZPerson *p = [[TZPerson alloc] init];
        // 吃东西
        //    [p eat];
        // OC:运行时机制,消息机制是运行时机制最重要的机制
        // 消息机制:任何方法调用,本质都是发送消息
    
        // SEL:方法编号,根据方法编号就可以找到对应方法实现
        //    [p performSelector:@selector(eat)];
    
    objc_msgSend(p, @selector(eat));
    objc_msgSend(p, @selector(run:), 10);
    
    Class Person = [TZPerson class];
    objc_msgSend(Person, @selector(eat));
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
