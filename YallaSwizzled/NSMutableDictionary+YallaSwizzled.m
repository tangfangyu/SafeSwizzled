//
//  NSMutableDictionary+YallaSwizzled.m
//  YallaGame
//
//  Created by fabs on 2018/7/19.
//  Copyright © 2018年 fabs. All rights reserved.
//

#import "NSMutableDictionary+YallaSwizzled.h"

@implementation NSMutableDictionary (YallaSwizzled)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Yalla_InstanceMethodSwizzled(objc_getClass("__NSDictionaryM"), @selector(setObject:forKey:), @selector(yalla_setObject:forKey:));
    });
}

- (void)yalla_setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    NSAssert(anObject, @"NSMutableDictionary setObject: Error");
    if (anObject) {
        [self yalla_setObject:anObject forKey:aKey];
    }
}

@end
