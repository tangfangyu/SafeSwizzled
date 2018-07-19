//
//  YallaCommonMacro.h
//  YallaGame
//
//  Created by fabs on 2018/7/12.
//  Copyright © 2018年 fabs. All rights reserved.
//

#ifndef YallaCommonMacro_h
#define YallaCommonMacro_h

/**
 * NSLog
 */
#ifndef YallaLog
#if DEBUG
#define YallaLog(fmt,...) NSLog(fmt,##__VA_ARGS__)
#else
#define YallaLog(...)
#endif
#endif

/**
 * 弱引用
 */
#ifndef weakify
#define weakify(obj) __weak typeof(obj) weak_##obj = obj
#endif

/**
 * 强引用
 */
#ifndef strongify
#define strongify(obj) __strong typeof(obj) obj = weak_##obj
#endif

/**
 * 安全回调
 */
#ifndef Yalla_SafeBlock
#define Yalla_SafeBlock(block,...) if (block) { block(__VA_ARGS__); }
#endif

/**
 * 判断是否是iPhoneX
 */
#ifndef Yalla_iPhoneX
#define Yalla_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125.0, 2436.0), [[UIScreen mainScreen] currentMode].size) : NO)
#endif


#endif /* YallaCommonMacro_h */
