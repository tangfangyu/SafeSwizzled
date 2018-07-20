//
//  NSData+YallaEncrypt.m
//  YallaGame
//
//  Created by fabs on 2018/7/20.
//  Copyright © 2018年 fabs. All rights reserved.
//

#import "NSData+YallaEncrypt.h"
#import <CommonCrypto/CommonCryptor.h>

@implementation NSData (YallaEncrypt)

- (NSData *)AES256WithKey:(NSString *)key isDecrypt:(BOOL)isDecrypt {
    char keyPtr[kCCKeySizeAES256 + 1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [self length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t bytes = 0;
    CCOperation operation = isDecrypt ? kCCDecrypt : kCCEncrypt;
    CCCryptorStatus status = CCCrypt(operation,
                                     kCCAlgorithmAES128,
                                     kCCOptionPKCS7Padding | kCCOptionECBMode,
                                     keyPtr,
                                     kCCBlockSizeAES128,
                                     NULL,
                                     [self bytes],
                                     dataLength,
                                     buffer,
                                     bufferSize,
                                     &bytes);
    if (status == kCCSuccess) {
        NSData *data = [NSData dataWithBytesNoCopy:buffer length:bytes];
        return data;
    }
    free(buffer);
    return nil;
}

@end
