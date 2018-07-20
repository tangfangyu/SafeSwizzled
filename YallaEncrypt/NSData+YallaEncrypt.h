//
//  NSData+YallaEncrypt.h
//  YallaGame
//
//  Created by fabs on 2018/7/20.
//  Copyright © 2018年 fabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (YallaEncrypt)

/**
 * AES256算法
 * key : 加/解密的key
 * isDecrypt : 是否是解密.默认是NO.
 */
- (NSData *)AES256WithKey:(NSString *)key isDecrypt:(BOOL)isDecrypt;

@end
