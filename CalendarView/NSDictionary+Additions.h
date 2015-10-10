//
//  NSDictionaryAdditions.h
//  WeiboPad
//
//  Created by junmin liu on 10-10-6.
//  Copyright 2010 Openlab. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSDictionary (Additions)

- (BOOL)boolValueForKey:(NSString *)key defaultValue:(BOOL)defaultValue;
- (NSInteger)integerValueForKey:(NSString *)key defaultValue:(NSInteger)defaultValue;
//- (CGFloat)floatValueForKey:(NSString*)key defaultValue:(CGFloat)defaultValue;
- (time_t)timeValueForKey:(NSString *)key defaultValue:(time_t)defaultValue;
- (long long)longLongValueValueForKey:(NSString *)key defaultValue:(long long)defaultValue;
- (NSString *)stringValueForKey:(NSString *)key defaultValue:(NSString *)defaultValue;
- (NSArray *)arrayValueForKey:(NSString *)key defaultValue:(NSArray *)defaultValue;
- (NSDictionary *)dictionaryValueForKey:(NSString *)key defaultValue:(NSDictionary *)defaultValue;
@end
