//
//  TZPerson.m
//  iOS Runtime Sample Code
//
//  Created by Tim.Z on 11/24/15.
//  Copyright © 2015 Tim.Z. All rights reserved.
//

#import "TZPerson.h"

@implementation TZPerson

- (void)eat
{
    NSLog(@"对象方法-吃东西");
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
