//
//  CalendarManager.h
//  Calender
//
//  Created by 陶柏同 on 15/5/26.
//  Copyright (c) 2015年 LaoTao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalendarManager : NSObject

@property (strong, nonatomic) NSCalendar *calendar;
@property (strong, nonatomic) NSDateFormatter *formatter;
@property (copy, nonatomic) NSString *calendarIdentifier; //日历标识符
@property (strong, nonatomic) NSLocale *local;  //日历指定的地区信息
@property (strong, nonatomic) NSTimeZone *timeZone; //日历指定的时区信息
@property (assign, nonatomic) NSUInteger firstWeekday;  //日历指定的每周的第一天从星期几开始。缺省为星期天 。firstWeekday = 1

@property (strong, nonatomic) NSDate *currentDate;  //当前选择的时间
@property (copy, nonatomic) NSString *currentStr;

+ (CalendarManager *)sharedManager;     //单例
- (NSCalendar *)calendar;
- (NSString *)calendarIdentifier ;  //返回日历标识符

@end
