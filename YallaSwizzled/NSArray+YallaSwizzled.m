//
//  NSArray+YallaSwizzled.m
//  YallaGame
//
//  Created by fabs on 2018/7/19.
//  Copyright © 2018年 fabs. All rights reserved.
//

#import "NSArray+YallaSwizzled.h"

@implementation NSArray (YallaSwizzled)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Yalla_InstanceMethodSwizzled(objc_getClass("__NSArrayI"), @selector(objectAtIndex:), @selector(yalla_objectAtIndex:));
    });
}

- (id)yalla_objectAtIndex:(NSUInteger)index {
    NSAssert(index < self.count, @"NSArray objectAtIndex: Error");
    if (index < self.count) {
        return [self yalla_objectAtIndex:index];
    }
    return nil;
}

@end
