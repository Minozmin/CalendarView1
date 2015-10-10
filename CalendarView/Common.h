//
//  Common.h
//  报修一站通1
//
//  Created by baoxiuyizhantong on 15/1/13.
//  Copyright (c) 2015年 报修一站通. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "MBProgressHUD.h"
#import "NSDictionary+Additions.h"

@interface Common : NSObject

/**
 * @brief
 *
 * Detailed comments of this function
 * @param[in]
 * @param[out]
 * @return
 * @note
 */
+ (NSString *)md5HexDigest:(NSString*)input;

//+ (void)showHud:(UIView *)view title:(NSString *)title animated:(BOOL)isAnimated;
//+ (void)hideHud:(UIView *)view animated:(BOOL)animated;
//
//+ (void)showAlert:(NSString *)message;
//+ (void)removeAlert:(NSTimer *)timer;

#pragma mark - 验证手机号  （简单）
+ (BOOL)validatePhone:(NSString *)phone;

#pragma mark - NSDate与NSString相互转换
+ (NSString *)stringFromDate:(NSDate *)date format:(NSString *)format;
+ (NSDate *)dateFromString:(NSString *)string format:(NSString *)format;

//get请求
+ (void)sendGetURL:(NSString *)url withParams:(NSDictionary *)dic success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;
+ (void)sendPostURL:(NSString *)url withParams:(NSDictionary *)dic success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;

/**
 *  获取给好的地址数组返回经纬度数组
 */
+(NSMutableArray *)getlngAndlatArray:(NSArray *)addressArray ;

@end
