//
//  NSString+YallaEncrypt.h
//  YallaGame
//
//  Created by fabs on 2018/7/20.
//  Copyright © 2018年 fabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSData+YallaEncrypt.h"

@interface NSString (YallaEncrypt)

/**
 * MD5加密
 */
- (NSString *)MD5;

/**
 * SHA1加密
 */
- (NSString *)SHA1;

/**
 * SHA256加密
 */
- (NSString *)SHA256;

/**
 * AES256加密
 */
- (NSString *)AES256EncryptWithKey:(NSString *)key;

/**
 * AES256解密
 */
- (NSString *)AES256DecryptWithKey:(NSString *)key;

@end
