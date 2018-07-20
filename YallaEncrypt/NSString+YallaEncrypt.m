//
//  NSString+YallaEncrypt.m
//  YallaGame
//
//  Created by fabs on 2018/7/20.
//  Copyright © 2018年 fabs. All rights reserved.
//

#import "NSString+YallaEncrypt.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>

@implementation NSString (YallaEncrypt)

- (NSString *)MD5 {
    const char *cString = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cString, (CC_LONG)strlen(cString), result);
    NSMutableString *string = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [string appendFormat:@"%02x",result[i]];
    }
    return string;
}

- (NSString *)SHA1 {
    const char *cString = [self UTF8String];
    NSData *data = [NSData dataWithBytes:cString length:self.length];
    uint8_t result[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (CC_LONG)data.length, result);
    NSMutableString *string = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [string appendFormat:@"%02x",result[i]];
    }
    return string;
}

- (NSString *)SHA256 {
    const char *cString = [self UTF8String];
    NSData *data = [NSData dataWithBytes:cString length:self.length];
    uint8_t result[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(data.bytes, (CC_LONG)data.length, result);
    NSMutableString *string = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_SHA256_DIGEST_LENGTH; i++) {
        [string appendFormat:@"%02x",result[i]];
    }
    return string;
}

- (NSString *)AES256EncryptWithKey:(NSString *)key {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSData *result = [data AES256WithKey:key isDecrypt:NO];
    return [result base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

- (NSString *)AES256DecryptWithKey:(NSString *)key {
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSData *result = [data AES256WithKey:key isDecrypt:YES];
    return [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
}


@end
