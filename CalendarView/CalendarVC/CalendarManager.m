//
//  CalendarManager.m
//  Calender
//
//  Created by 陶柏同 on 15/5/26.
//  Copyright (c) 2015年 LaoTao. All rights reserved.
//

#import "CalendarManager.h"

@implementation CalendarManager

+ (CalendarManager *)sharedManager {
    
    static CalendarManager *sharedManager;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (NSCalendar *)calendar
{
    static NSCalendar *calendar;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        calendar.timeZone = [NSTimeZone localTimeZone];
        calendar.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
        [calendar setFirstWeekday:1];   //Sunday == 1, Saturday == 7;
        self.calendar = calendar;
    });
    
    return calendar;
}

- (NSDateFormatter *)formatter {
    static NSDateFormatter *formatter;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
       formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setDateStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"yyyy年MM月dd日"];
        
        NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
        [formatter setTimeZone:timeZone];
    });
    
    return formatter;
}

#pragma mark - 返回日历标识符
- (NSString *)calendarIdentifier {
    return [self.calendar calendarIdentifier];
}

- (NSLocale *)locale {
    return [self.calendar locale];
}

- (NSTimeZone *)timeZone {
    return [self.calendar timeZone];
}

- (NSUInteger)firstWeekday {
    return [self.calendar firstWeekday];
    /*
     当方法[NSCalendar ordinalityOfUnit: inUnit: fromDate:]
         的ordinalityOfUnit参数为NSWeekdayCalendarUnit，inUnit参数为NSWeekCalendarUnit时，
             firstWeekday属性影响它的返回值。具体说明如下:     .  当firstWeekday被指定为星期天(即 = 1)时，它返回的值与星期几对应的数值保持一致。比如:
            fromDate传入的参数是星期日，则函数返回1        fromDate传入的参数是星期一，则函数返回2
         .  当firstWeekday被指定为其它值时(即 <> 1)时，假设firstWeekday被指定为星期一(即 = 2)，那么:
     fromDate传入的参数是星期一，则函数返回1        fromDate传入的参数是星期二，则函数返回2        fromDate传入的参数是星期日，则函数返回7
     */
}

@end
