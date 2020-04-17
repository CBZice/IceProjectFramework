//
//  NSString+RXUtility.m
//  RXCategory
//
//  Created by Rush.D.Xzj on 15/4/17.
//  Copyright (c) 2015年 Rush.D.Xzj. All rights reserved.
//

#import "NSString+RXUtility.h"

#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonKeyDerivation.h>

@implementation NSString (RXUtility)

- (BOOL)rx_isValidateEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
    return [emailTest evaluateWithObject:self];
    
}





- (NSString *)rx_hiddenMobileFormatString
{
    NSRange range;
    range.location = 3;
    range.length = 4;
    return [self stringByReplacingCharactersInRange:range withString:@"****"];
}
- (BOOL)rx_isChinese
{
    for (NSInteger i = 0; i < self.length; i++){
        int a = [self characterAtIndex:i];
        if(a > 0x4e00 && a < 0x9fff)
        {
            return YES;
        }
        
    }
    return NO;
}

- (BOOL)rx_containEmoji
{
    __block BOOL returnValue = NO;
    NSInteger count = self.length;
    [self enumerateSubstringsInRange:NSMakeRange(0, count) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        const unichar hs = [substring characterAtIndex:0];
        if (0xd800 <= hs && hs <= 0xdbff) {
            if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                if (0x1d000 <= uc && uc <= 0x1f77f) {
                    returnValue = YES;
                }
            }
        } else if (substring.length > 1) {
            const unichar ls = [substring characterAtIndex:1];
            if (ls == 0x20e3) {
                returnValue = YES;
            }
        } else {
            if (0x2100 <= hs && hs <= 0x27ff) {
                returnValue = YES;
            } else if (0x2B05 <= hs && hs <= 0x2b07) {
                returnValue = YES;
            } else if (0x2934 <= hs && hs <= 0x2935) {
                returnValue = YES;
            } else if (0x3297 <= hs && hs <= 0x3299) {
                returnValue = YES;
            } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                returnValue = YES;
            }
        }
    }];
    
    return returnValue;
}

- (BOOL)rx_isChinaMobileFormat
{
    NSString *regex = @"^1\\d{10}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}
- (NSString *)rx_md5
{
    return [self rx_transform_MD5];
    
}

- (BOOL)rx_isPureInt
{
    NSScanner* scan = [NSScanner scannerWithString:self];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}
// 非0的正整数
- (BOOL)rx_isNoZeorIntValue
{
    NSRange range = [self rangeOfString:@"."];
    if (range.length > 0) {
        return NO;
    }
    
    int value = [self intValue];
    NSString *str = [NSString stringWithFormat:@"%d", value];
    if (value <= 0) {
        return NO;
    }
    if (![str isEqualToString:self]) {
        return NO;
    }
    return YES;

}


- (BOOL)rx_isTwoDoubleIntValueWithString:(NSString *)str
{
    double value = [str doubleValue];
    
    if (value <= 0) {
        return NO;
    }
    NSRange range = [str rangeOfString:@"."];
    NSString *str2 = [str substringFromIndex:range.location];
    
    if (str2.length > 3) {
        return NO;
    }
    return YES;
    
}

- (NSString *)rx_transformToPinyin
{
    return [self rx_transform_Phoneticize];
}

+ (NSString *)rx_validStringWithObj:(id)obj
{
    if ([obj isKindOfClass:[NSString class]]) {
        NSString *tmp = obj;
        return tmp.length > 0 ? tmp : @"";
    } else if ([obj isKindOfClass:[NSNull class]]) {
        return @"";
    } else {
        NSString *result = [NSString stringWithFormat:@"%@", obj];
        return result;
    }
}



#pragma mark - Override NSString Method
- (NSString *)rx_stringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement
{
    if (target.length == 0) {
        return self;
    }
    
    if ([self containsString:target]) {
        return [self stringByReplacingOccurrencesOfString:target withString:replacement];
    } else {
        return self;
    }
    
}

#pragma mark - Phoneticize
- (NSString *)rx_transform_Phoneticize
{
    NSMutableString *mutableString = [NSMutableString stringWithString:self];
    CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformToLatin, false);
    CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformStripDiacritics, false);
    NSString *result = [NSString stringWithFormat:@"%@", mutableString];
    result = [result stringByReplacingOccurrencesOfString:@" " withString:@""];
    return result;
}


#pragma mark - Base64 Encode/Decode
- (NSString *)rx_transform_Base64Encode
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSString *resultString = [data base64EncodedStringWithOptions:0];
    return resultString;
}

- (NSString *)rx_transform_Base64Decode
{
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:0];
    NSString *resultString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return resultString;
}


#pragma mark - URL Encode/Decode
- (NSString *)rx_transform_URLEncode
{
    CFStringEncoding encoding = CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding);
    CFStringRef stringRef = CFURLCreateStringByAddingPercentEscapes(NULL, (__bridge CFStringRef)self, NULL, (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ", encoding);
    return  (__bridge_transfer NSString *)stringRef;
}

- (NSString *)rx_transform_URLDecode
{
    CFStringEncoding encoding = CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding);
    CFStringRef stringRef = CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)self, CFSTR(""), encoding);
    return  (__bridge_transfer NSString *)stringRef;
}

#pragma mark - MD5
- (NSString *)rx_transform_MD5
{
    const char *input = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    NSMutableString *resultString = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [resultString appendFormat:@"%02x", result[i]];
    }
    return [resultString lowercaseString];
}

- (UIImage *)rx_transform_Base64Image
{
    NSData *decodedImageData = [[NSData alloc] initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
    UIImage *decodedImage = [UIImage imageWithData:decodedImageData];
    return decodedImage;
}



#pragma mark - AES Encrypt/Decrypt
#pragma mark Public
static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
const NSUInteger kAlgorithmKeySize = kCCKeySizeAES128;
const NSUInteger kKeyLength = 128;
const NSUInteger kPBKDFRounds = 10000;  // ~80ms on an iPhone 4
static Byte saltBuff[] = {0,1,2,3,4,5,6,7,8,9,0xA,0xB,0xC,0xD,0xE,0xF};
static Byte ivBuff[]   = {0xA,1,0xB,5,4,0xF,7,9,0x17,3,1,6,8,0xC,0xD,91};


- (NSString *)rx_transform_AES128EncryptWithKey:(NSString *)key
{
    NSData *sourceData = [self dataUsingEncoding:NSUTF8StringEncoding];
    // 'key' should be 32 bytes for AES256, will be null-padded otherwise
    char keyPtr[kAlgorithmKeySize+1]; // room for terminator (unused)
    bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)
    NSUInteger dataLength = sourceData.length;
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    bzero(buffer, sizeof(buffer));
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128,kCCOptionPKCS7Padding|kCCOptionECBMode,
                                          [[key __private_aesKeyData] bytes], kAlgorithmKeySize,
                                          NULL /* initialization vector (optional) */,
                                          [sourceData bytes], dataLength, /* input */
                                          buffer, bufferSize, /* output */
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *encryptData = [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
        return [NSString convertDataToHexStr:encryptData];
//        return [[NSString alloc] initWithData:encryptData encoding:kCFStringEncodingUTF8];
    }
    free(buffer); //free the buffer;
    return @"";
}
- (NSString *)rx_transform_AES128DecryptWithKey:(NSString *)key
{
    NSData *cipherData = [NSString convertHexStrToData:self];
//    NSData *cipherData = [self dataUsingEncoding:kCFStringEncodingUTF8];
    // 'key' should be 32 bytes for AES256, will be null-padded otherwise
    char keyPtr[kAlgorithmKeySize+1]; // room for terminator (unused)
    bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)
    NSUInteger dataLength = [cipherData length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding|kCCOptionECBMode,
                                          [[key __private_aesKeyData] bytes], kAlgorithmKeySize,
                                          NULL ,/* initialization vector (optional) */
                                          [cipherData bytes], dataLength, /* input */
                                          buffer, bufferSize, /* output */
                                          &numBytesDecrypted);
    
    if (cryptStatus == kCCSuccess) {
        NSData *encryptData = [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
        return [[[NSString alloc] initWithData:encryptData encoding:NSUTF8StringEncoding] init];
    }
    
    free(buffer); //free the buffer;
    return @"";
    
}

+ (NSString *)convertDataToHexStr:(NSData *)data
{
    if (!data || [data length] == 0) {
        return @"";
    }
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[data length]];
    
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i = 0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            if ([hexStr length] == 2) {
                [string appendString:hexStr];
            } else {
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];
    return string;
}

+ (NSData *)convertHexStrToData:(NSString *)str
{
    if (!str || [str length] == 0) {
        return nil;
    }
    
    NSMutableData *hexData = [[NSMutableData alloc] initWithCapacity:20];
    NSRange range;
    if ([str length] % 2 == 0) {
        range = NSMakeRange(0, 2);
    } else {
        range = NSMakeRange(0, 1);
    }
    for (NSInteger i = range.location; i < [str length]; i += 2) {
        unsigned int anInt;
        NSString *hexCharStr = [str substringWithRange:range];
        NSScanner *scanner = [[NSScanner alloc] initWithString:hexCharStr];
        
        [scanner scanHexInt:&anInt];
        NSData *entity = [[NSData alloc] initWithBytes:&anInt length:1];
        [hexData appendData:entity];
        
        range.location += range.length;
        range.length = 2;
    }
    return hexData;
}

- (NSData *)__private_aesKeyData
{
    NSMutableData *derivedKey = [NSMutableData dataWithLength:kAlgorithmKeySize];
    NSData *salt = [NSData dataWithBytes:saltBuff length:kAlgorithmKeySize];
    int result = CCKeyDerivationPBKDF(kCCPBKDF2,        // algorithm算法
                                      self.UTF8String,  // password密码
                                      self.length,      // passwordLength密码的长度
                                      salt.bytes,           // salt内容
                                      salt.length,          // saltLen长度
                                      kCCPRFHmacAlgSHA1,    // PRF
                                      kPBKDFRounds,         // rounds循环次数
                                      derivedKey.mutableBytes, // derivedKey
                                      derivedKey.length);   // derivedKeyLen derive:出自
    
    NSAssert(result == kCCSuccess, @"Unable to create AES key for spassword: %d", result);
    if (result == kCCSuccess) {
        return derivedKey;
    } else {
        return [NSData new];
    }
}

- (id)__private_base64EnCodedData
{
    if (self.length == 0) {
        return [NSData data];
    }
    static char *decodingTable = NULL;
    if (decodingTable == NULL) {
        decodingTable = malloc(kKeyLength);
        if (decodingTable == NULL) {
            return [NSData data];
        }
        memset(decodingTable, CHAR_MAX, kKeyLength);
        NSUInteger i;
        for (i = 0; i < 64; i++) {
            decodingTable[(short)encodingTable[i]] = i;
        }
    }
    
    const char *characters = [self cStringUsingEncoding:NSASCIIStringEncoding];
    if (characters == NULL) {    //  Not an ASCII string!
        return [NSData data];
    }
    char *bytes = malloc((([self length] + 3) / 4) * 3);
    if (bytes == NULL) {
        return [NSData data];
    }
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (YES) {
        char buffer[4];
        short bufferLength;
        for (bufferLength = 0; bufferLength < 4; i++) {
            if (characters[i] == '\0') {
                break;
            }
            if (isspace(characters[i]) || characters[i] == '=') {
                continue;
            }
            buffer[bufferLength] = decodingTable[(short)characters[i]];
            if (buffer[bufferLength++] == CHAR_MAX) {    //  Illegal character!
                free(bytes);
                return [NSData data];
            }
        }
        
        if (bufferLength == 0) {
            break;
        }
        if (bufferLength == 1) {     //  At least two characters are needed to produce one byte!
            free(bytes);
            return [NSData data];
        }
        
        //  Decode the characters in the buffer to bytes.
        bytes[length++] = (buffer[0] << 2) | (buffer[1] >> 4);
        if (bufferLength > 2) {
            bytes[length++] = (buffer[1] << 4) | (buffer[2] >> 2);
        }
        if (bufferLength > 3) {
            bytes[length++] = (buffer[2] << 6) | buffer[3];
        }
    }
    
    bytes = realloc(bytes, length);
    return [NSData dataWithBytesNoCopy:bytes length:length];
}



+ (NSString *)__private_base64EncodingWithData:(NSData *)data;
{
    if (data.length == 0)
        return @"";
    
    char *characters = malloc(((data.length + 2) / 3) * 4);
    if (characters == NULL) {
        return @"";
    }
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (i < data.length) {
        char buffer[3] = {0,0,0};
        short bufferLength = 0;
        while (bufferLength < 3 && i < data.length) {
            buffer[bufferLength++] = ((char *)[data bytes])[i++];
        }
        //  Encode the bytes in the buffer to four characters, including padding "=" characters if necessary.
        characters[length++] = encodingTable[(buffer[0] & 0xFC) >> 2];
        characters[length++] = encodingTable[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
        if (bufferLength > 1) {
            characters[length++] = encodingTable[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
        } else {
            characters[length++] = '=';
        }
        if (bufferLength > 2) {
            characters[length++] = encodingTable[buffer[2] & 0x3F];
        } else {
            characters[length++] = '=';
        }
    }
    
    return [[[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSASCIIStringEncoding freeWhenDone:YES] init];
}

@end
