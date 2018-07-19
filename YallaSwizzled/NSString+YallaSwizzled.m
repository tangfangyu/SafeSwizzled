//
//  NSString+YallaSwizzled.m
//  YallaGame
//
//  Created by fabs on 2018/7/19.
//  Copyright © 2018年 fabs. All rights reserved.
//

#import "NSString+YallaSwizzled.h"

@implementation NSString (YallaSwizzled)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Yalla_InstanceMethodSwizzled([self class], @selector(substringFromIndex:), @selector(yalla_substringFromIndex:));
        Yalla_InstanceMethodSwizzled([self class], @selector(substringToIndex:), @selector(yalla_substringToIndex:));
        Yalla_InstanceMethodSwizzled([self class], @selector(substringWithRange:), @selector(yalla_substringWithRange:));
    });
}

- (NSString *)yalla_substringFromIndex:(NSUInteger)from {
    NSAssert(from <= self.length, @"NSString substringFromIndex: Error");
    if (from <= self.length) {
        return @"";
    }
     return [self yalla_substringFromIndex:from];
}

- (NSString *)yalla_substringToIndex:(NSUInteger)to {
    NSAssert(to <= self.length, @"NSString substringToIndex: Error");
    if (to > self.length) {
        return @"";
    }
    return [self yalla_substringToIndex:to];
}

- (NSString *)yalla_substringWithRange:(NSRange)range {
    NSAssert((range.location + range.length) <= self.length, @"NSString substringWithRange: Error");
    if ((range.location + range.length) > self.length) {
        return @"";
    }
    return [self yalla_substringWithRange:range];
}

@end
