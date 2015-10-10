//
//  Common.m
//  报修一站通1
//
//  Created by baoxiuyizhantong on 15/1/13.
//  Copyright (c) 2015年 报修一站通. All rights reserved.
//

#import "Common.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>
#import <arpa/inet.h>
#import "AFNetworking.h"

@implementation Common{
    NSInteger netStatus;
}

#pragma mark - md加密
+ (NSString *)md5HexDigest:(NSString*)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (int)strlen(cStr), result );
    return [[NSString stringWithFormat:
             @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}

//#pragma mark - hud提示
//+ (void)showHud:(UIView *)view title:(NSString *)title animated:(BOOL)isAnimated
//{
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:isAnimated];
//    hud.labelText = title;
//    hud.dimBackground = NO;
//}
//+ (void)hideHud:(UIView *)view animated:(BOOL)animated
//{
//    [MBProgressHUD hideHUDForView:view animated:animated];
//}
//
//#pragma mark - alert提示
//+ (void)showAlert:(NSString *)message
//{
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
//    [alert show];
//    
//    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(removeAlert:) userInfo:[NSDictionary dictionaryWithObjectsAndKeys:alert, @"alert", nil] repeats:NO];
//}
//
//+ (void)removeAlert:(NSTimer *)timer
//{
//    UIAlertView *alert = (UIAlertView *)[timer.userInfo objectForKey:@"alert"];
//    [alert dismissWithClickedButtonIndex:0 animated:YES];
//    [timer invalidate];
//    timer = nil;
//}

#pragma mark - 验证手机号  （简单）
+ (BOOL)validatePhone:(NSString *)phone
{
    NSString *phoneRegex = @"1[3|5|7|8|][0-9]{9}";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:phone];
}

#pragma mark - NSDate与NSString相互转换

//NSDate转NSString
+ (NSString *)stringFromDate:(NSDate *)date format:(NSString *)format
{
    //获取系统当前时间
//    NSDate *currentDate = [NSDate date];
    //用于格式化NSDate对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设置格式：zzz表示时区
    [dateFormatter setDateFormat:format];
    //NSDate转NSString
    NSString *currentDateString = [dateFormatter stringFromDate:date];
    //输出currentDateString
//    NSLog(@"%@",currentDateString);
    return currentDateString;
}

//NSString转NSDate
+ (NSDate *)dateFromString:(NSString *)string format:(NSString *)format
{
    //需要转换的字符串
//    NSString *dateString = @"2015-06-26 08:08:08";
    //设置转换格式
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:format];
    //NSString转NSDate
    NSDate *date=[formatter dateFromString:string];
    return date;
}

#pragma mark - 数据请求 get

+ (void)sendGetURL:(NSString *)url withParams:(NSDictionary *)dic success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [[AFHTTPResponseSerializer alloc]init];
        [manager GET:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSString *requestTmp = [NSString stringWithString:operation.responseString];
            NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
            //系统自带JSON解析
            NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
            success(resultDic);
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            failure(error);
        }];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
    });
}


#pragma mark - 数据请求 post

+ (void)sendPostURL:(NSString *)url withParams:(NSDictionary *)dic success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        //获得请求管理
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [[AFHTTPResponseSerializer alloc]init];
        //发送post请求
        [manager.requestSerializer setTimeoutInterval:5.0];
        [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {

            NSString *requestTmp = [NSString stringWithString:operation.responseString];
            NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
            //系统自带JSON解析
            NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
            success(resultDic);
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            failure(error);
        }];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
    });
}
//
///**
// *  获取给好的地址数组返回经纬度数组
// */
//+(NSMutableArray *)getlngAndlatArray:(NSArray *)addressArray {
//
//    NSMutableArray *lgAndLaArray = [NSMutableArray array];
//    NSMutableArray *lgArray = [NSMutableArray array];
//    NSMutableArray *laArray = [NSMutableArray array];
//    for (NSDictionary *dict in addressArray) {
//        NSString *oreillyAddress = dict [@"address"];
//        CLGeocoder *myGeocoder = [[CLGeocoder alloc] init];
//        [myGeocoder geocodeAddressString:oreillyAddress completionHandler:^(NSArray *placemarks, NSError *error) {
//            if ([placemarks count] > 0 && error == nil) {
//                CLPlacemark *firstPlacemark = [placemarks objectAtIndex:0];
//                
//                NSString *lgStr = [NSString stringWithFormat:@"%f", firstPlacemark.location.coordinate.longitude];
//                [lgArray addObject:lgStr];
//                
//                NSString *laStr = [NSString stringWithFormat:@"%f",firstPlacemark.location.coordinate.latitude];
//                [laArray addObject:laStr];
//                
//                [lgAndLaArray addObject:@[lgArray, laArray]];
//            }
//            
//        }];
//    }
//    return lgAndLaArray;
//}

@end
