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

    //通过class_addMethod动态添加方法
- (IBAction)addMethod:(id)sender
{
        // 默认一个方法都有两个参数,self,_cmd,隐式参数
        // self:方法调用者
        // _cmd:调用方法的编号
    
        // 动态添加方法,首先实现这个resolveInstanceMethod
        // resolveInstanceMethod调用:当调用了没有实现的方法没有实现就会调用resolveInstanceMethod
        // resolveInstanceMethod作用:就知道哪些方法没有实现,从而动态添加方法
        // sel:没有实现方法
    TZPerson *p = [[TZPerson alloc] init];
    
    /**
     *  void aaa(id self, SEL _cmd, id param1){
        NSLog(@"调用sing: %@ %@ %@",self,NSStringFromSelector(_cmd),param1);
        }
     
     + (BOOL)resolveInstanceMethod:(SEL)sel
        {
        if (sel == @selector(sing:)) {
     cls:给哪个类添加方法
     SEL:添加方法的方法编号是什么
     IMP:方法实现,函数入口,函数名
     types:方法类型
        class_addMethod(self, sel, (IMP)aaa, "v@:@");
     
        return YES;
        }
        return [super resolveInstanceMethod:sel];
        }
     */
    [p performSelector:@selector(sing:) withObject:@111];
}

    //通过method_exchangeImplementations交换实现
- (IBAction)exchangeImplementations:(id)sender
{
    /**
     * +(void)load
     {
     //class_getClassMethod(__unsafe_unretained Class cls, SEL name)
     //class_getInstanceMethod(__unsafe_unretained Class cls, SEL name)
     Method eatMethod = class_getInstanceMethod([TZPerson class], @selector(eat));
     
     
     Method jumpMethod = class_getInstanceMethod([TZPerson class], @selector(jump));
     
     method_exchangeImplementations(eatMethod, jumpMethod);
     }
     */
    
    TZPerson *p = [[TZPerson alloc] init];
    
    objc_msgSend(p, @selector(eat));
//    objc_msgSend(p, @selector(jump));
}


    //通过objc_msgSend发送消息
- (IBAction)sendMsg:(id)sender
{
    TZPerson *p = [[TZPerson alloc] init];
    /**
     *   吃东西
        [p eat];
        OC:运行时机制,消息机制是运行时机制最重要的机制
        消息机制:任何方法调用,本质都是发送消息
     
        SEL:方法编号,根据方法编号就可以找到对应方法实现
        [p performSelector:@selector(eat)];
     
        消息机制原理:对象根据方法编号SEL去映射表查找对应的方法实现
 
     */
    
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
