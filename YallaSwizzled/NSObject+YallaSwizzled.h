//
//  NSObject+YallaSwizzled.h
//  YallaGame
//
//  Created by fabs on 2018/7/19.
//  Copyright © 2018年 fabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (YallaSwizzled)

@end


@interface YallaUnrecognizedSelector : NSObject

+ (instancetype)shareInstance;

@end
