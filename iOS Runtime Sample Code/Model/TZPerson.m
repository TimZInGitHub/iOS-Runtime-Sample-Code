//
//  TZPerson.m
//  iOS Runtime Sample Code
//
//  Created by Tim.Z on 11/24/15.
//  Copyright © 2015 Tim.Z. All rights reserved.
//

#import "TZPerson.h"
    //导入<objc/message.h>
#import <objc/message.h>
#import <UIKit/UIKit.h>

@implementation TZPerson

+(void)load
{
    Method eatMethod = class_getInstanceMethod([TZPerson class], @selector(eat));
    
    
    Method jumpMethod = class_getInstanceMethod([TZPerson class], @selector(jump));
    
    method_exchangeImplementations(eatMethod, jumpMethod);
}

#pragma mark - addMethod
void aaa(id self, SEL _cmd, id param1){
    NSLog(@"调用sing: %@ %@ %@",self,NSStringFromSelector(_cmd),param1);
}

+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    if (sel == @selector(sing:)) {
        
        class_addMethod(self, sel, (IMP)aaa, "v@:@");
        
        return YES;
    }
    
    return [super resolveInstanceMethod:sel];
}

#pragma mark - method
- (void)eat
{
    NSLog(@"对象方法-吃东西");
}

- (void)jump
{
    NSLog(@"对象方法-跳跃");
}

+ (void)eat
{
    NSLog(@"类方法-吃东西");
}

- (void)run:(int)age
{
    NSLog(@"%d",age);
}

@end
