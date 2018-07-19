//
//  YallaCommonFunction.h
//  YallaGame
//
//  Created by fabs on 2018/7/12.
//  Copyright © 2018年 fabs. All rights reserved.
//

#ifndef YallaCommonFunction_h
#define YallaCommonFunction_h

/**
 * 类方法交换
 */
FOUNDATION_STATIC_INLINE void Yalla_ClassMethodSwizzled(__unsafe_unretained Class aClass, SEL origSEL, SEL swizzledSEL) {
    Method originalMethod = class_getClassMethod(aClass, origSEL);
    Method swizzledMethod = class_getClassMethod(aClass, swizzledSEL);
    BOOL didAddMethod = class_addMethod(aClass,
                                        origSEL,
                                        class_getMethodImplementation(aClass, origSEL),
                                        method_getTypeEncoding(originalMethod));
    if (!swizzledMethod) {
        class_addMethod(aClass,
                        swizzledSEL,
                        class_getMethodImplementation(aClass, swizzledSEL),
                        method_getTypeEncoding(swizzledMethod));
    }
    if (didAddMethod) {
        class_replaceMethod(aClass,
                            swizzledSEL,
                            class_getMethodImplementation(aClass, origSEL),
                            method_getTypeEncoding(originalMethod));
    }else{
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

/**
 * 实例方法交换
 */
FOUNDATION_STATIC_INLINE void Yalla_InstanceMethodSwizzled(__unsafe_unretained Class aClass, SEL origSEL, SEL swizzledSEL) {
    Method originalMethod = class_getInstanceMethod(aClass, origSEL);
    Method swizzledMethod = class_getInstanceMethod(aClass, swizzledSEL);
    
    /*
      当子类未实现父类的origSEL时,originalMethod是父类的方法.这时method_exchangeImplementations交换的是父类的方法,不是想要的结果,所以尝试调用class_addMethod添加origSEL.
     */
    BOOL didAddMethod = class_addMethod(aClass,
                                        origSEL,
                                        method_getImplementation(originalMethod),
                                        method_getTypeEncoding(originalMethod));
    if (!swizzledMethod) {
        // 方法为空时,添加方法
        class_addMethod(aClass,
                        swizzledSEL,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));
    }
    if (didAddMethod) {
        class_replaceMethod(aClass,
                            swizzledSEL,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    }else{
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

/**
 * 判断支持的最低版本
 */
FOUNDATION_STATIC_INLINE void Yalla_AvailableVersion(CGFloat version,void(^block)(void)) {
    if ([UIDevice currentDevice].systemVersion.floatValue >= version) {
        Yalla_SafeBlock(block);
    }
}

/**
 * 主线程回调
 */
FOUNDATION_STATIC_INLINE void Yalla_SafeMainThreadBlock(dispatch_block_t block) {
    if (!block) { return; }
    if ([NSThread currentThread].isMainThread) {
        block();
        return;
    }
    dispatch_async(dispatch_get_main_queue(), block);
}

/**
 * 像素
 */
FOUNDATION_STATIC_INLINE CGFloat Yalla_ConversionPixel(CGFloat pt) {
    return pt/[UIScreen mainScreen].scale;
}

/**
 * 状态栏高度
 */
FOUNDATION_STATIC_INLINE CGFloat Yalla_StatusBarHeight() {
    return Yalla_iPhoneX ? 44.0 : 20.0;
}

/**
 * 导航栏高度
 */
FOUNDATION_STATIC_INLINE CGFloat Yalla_NavigationBarHeight() {
    return 44.0 + Yalla_StatusBarHeight();
}

/**
 * TabBar偏移量
 */
FOUNDATION_STATIC_INLINE CGFloat Yalla_TabBarBottomOffset() {
    return Yalla_iPhoneX ? 34.0 : 0.0;
}

/**
 * TabBar高度
 */
FOUNDATION_STATIC_INLINE CGFloat Yalla_TabBarHeight() {
    return 49.0 + Yalla_TabBarBottomOffset();
}

/**
 * 判断字符串是否为空
 */
FOUNDATION_STATIC_INLINE BOOL Yalla_isEmptyString(NSString *string) {
    if ([string isKindOfClass:[NSNumber class]]) {
        return NO;
    }
    if (!string || [string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    return !string.length;
}

#endif /* YallaCommonFunction_h */
