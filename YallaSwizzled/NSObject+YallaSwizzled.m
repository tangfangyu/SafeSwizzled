//
//  NSObject+YallaSwizzled.m
//  YallaGame
//
//  Created by fabs on 2018/7/19.
//  Copyright © 2018年 fabs. All rights reserved.
//

#import "NSObject+YallaSwizzled.h"

/*  消息转发流程
 *  1.resolveClassMethod/resolveInstanceMethod 检测方法是否已经处理.返回YES时,代表消息已经处理.返回NO时,消息未找到,class_addMethod添加方法.
 *  2.forwardingTargetForSelector 返回处理消息的对象
 *  3.forwardInvocation(函数执行器)调用methodSignatureForSelector获取方法相应的target.taregt存在时,调用目标的方法.不存在时,进入转发流程
 *  4.doesNotRecognizeSelector 都不处理.抛出异常.
 */

@implementation NSObject (YallaSwizzled)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Yalla_InstanceMethodSwizzled([self class], @selector(forwardingTargetForSelector:), @selector(yalla_forwardingTargetForSelector:));
        Yalla_InstanceMethodSwizzled([self class], @selector(methodSignatureForSelector:), @selector(yalla_methodSignatureForSelector:));
        Yalla_InstanceMethodSwizzled([self class], @selector(forwardInvocation:), @selector(yalla_forwardInvocation:));
    });
}

#pragma mark - forwardTarget Methods
- (id)yalla_forwardingTargetForSelector:(SEL)aSelector {
    YallaUnrecognizedSelector *unrecognizedSelector = [YallaUnrecognizedSelector shareInstance];
    return unrecognizedSelector;
}

- (NSMethodSignature *)yalla_methodSignatureForSelector:(SEL)aSelector {
    YallaUnrecognizedSelector *unrecognizedSelector = [YallaUnrecognizedSelector shareInstance];
    return [self yalla_methodSignatureForSelector:aSelector] ? : [unrecognizedSelector yalla_methodSignatureForSelector:aSelector];
}

- (void)yalla_forwardInvocation:(NSInvocation *)anInvocation {
    if ([self yalla_methodSignatureForSelector:anInvocation.selector]) {
        [self yalla_forwardInvocation:anInvocation];
        return;
    }
    YallaUnrecognizedSelector *unrecognizedSelector = [YallaUnrecognizedSelector shareInstance];
    if ([self methodSignatureForSelector:anInvocation.selector]) {
        [anInvocation invokeWithTarget:unrecognizedSelector];
    }
}
#pragma mark -

@end


@implementation YallaUnrecognizedSelector

id YallaAddMethodIMP(id self, SEL _cmd) {
    YallaLog(@"\n<<< !!! %@ unrecognized selector: %@ !!! >>>\n",NSStringFromClass([self class]),NSStringFromSelector(_cmd));
    return 0;
}

+ (instancetype)shareInstance {
    static YallaUnrecognizedSelector *unrecognizedSelector = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!unrecognizedSelector) {
            unrecognizedSelector = [[[self class] alloc] init];
        }
    });
    return unrecognizedSelector;
}

+ (BOOL)resolveClassMethod:(SEL)sel {
    BOOL resolve = [super resolveInstanceMethod:sel];
    if (!resolve) {
        class_addMethod([self class], sel, (IMP)YallaAddMethodIMP,"v@:@");
        return YES;
    }
    return resolve;
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    BOOL resolve = [super resolveInstanceMethod:sel];
    NSAssert(resolve, @"\n<<< !!! %@ unrecognized selector: %@ !!! >>>\n",NSStringFromClass([self class]),NSStringFromSelector(sel));
    if (!resolve) {
        class_addMethod([self class], sel, (IMP)YallaAddMethodIMP,"v@:@");
        return YES;
    }
    return resolve;
}

@end
