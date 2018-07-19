//
//  NSMutableArray+YallaSwizzled.m
//  YallaGame
//
//  Created by fabs on 2018/7/19.
//  Copyright © 2018年 fabs. All rights reserved.
//

#import "NSMutableArray+YallaSwizzled.h"

@implementation NSMutableArray (YallaSwizzled)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Yalla_InstanceMethodSwizzled(objc_getClass("__NSArrayM"), @selector(objectAtIndex:), @selector(yalla_objectAtIndex:));
//        Yalla_InstanceMethodSwizzled(objc_getClass("__NSArrayM"), @selector(insertObject:atIndex:), @selector(yalla_insertObject:atIndex:));
        Yalla_InstanceMethodSwizzled(objc_getClass("__NSArrayM"), @selector(removeObjectAtIndex:), @selector(yalla_removeObjectAtIndex:));
        Yalla_InstanceMethodSwizzled(objc_getClass("__NSArrayM"), @selector(replaceObjectAtIndex:withObject:), @selector(yalla_replaceObjectAtIndex:withObject:));
        Yalla_InstanceMethodSwizzled(objc_getClass("__NSArrayM"), @selector(exchangeObjectAtIndex:withObjectAtIndex:), @selector(yalla_exchangeObjectAtIndex:withObjectAtIndex:));
    });
}

- (id)yalla_objectAtIndex:(NSUInteger)index {
    NSAssert(index < self.count, @"NSMutableArray objectAtIndex: Error");
    if (index < self.count) {
        return [self yalla_objectAtIndex:index];
    }
    return nil;
}

//- (void)yalla_insertObject:(id)anObject atIndex:(NSUInteger)index {
//    if (index < self.count) {
//        [self yalla_insertObject:anObject atIndex:index];
//    }
//}

- (void)yalla_removeObjectAtIndex:(NSUInteger)index {
    NSAssert(index < self.count, @"NSMutableArray removeObjectAtIndex: Error");
    if (index < self.count) {
        [self yalla_removeObjectAtIndex:index];
    }
}

- (void)yalla_replaceObjectAtIndex:(NSUInteger)index withObject:(id)object {
    NSAssert(index < self.count, @"NSMutableArray replaceObjectAtIndex:withObject: Error");
    if (index < self.count) {
        [self yalla_replaceObjectAtIndex:index withObject:object];
    }
}

- (void)yalla_exchangeObjectAtIndex:(NSUInteger)idx withObjectAtIndex:(NSUInteger)idx2 {
    NSAssert(idx < self.count, @"NSMutableArray exchangeObjectAtIndex:withObjectAtIndex: Error");
    NSAssert(idx2 < self.count, @"NSMutableArray exchangeObjectAtIndex:withObjectAtIndex: Error");
    if (idx < self.count && idx2 < self.count) {
        [self yalla_exchangeObjectAtIndex:idx withObjectAtIndex:idx2];
    }
}

@end
