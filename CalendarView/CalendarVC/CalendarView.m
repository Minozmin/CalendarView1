//
//  CalendarView.m
//  baoxiu51
//
//  Created by baoxiuyizhantong on 15/7/24.
//  Copyright (c) 2015年 baoxiuyizhantong. All rights reserved.
//

#import "CalendarView.h"
#import "CalendarManager.h"

@implementation CalendarView
{
    UIButton *selectedBtn;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self comonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        [self comonInit];
    }
    return self;
}

- (void)comonInit
{
    _viewsArr = [[NSMutableArray alloc] init];
    CGFloat width = self.frame.size.width;
    
    for (int i = 0; i < 7; i++) {
        BlockCalendarButton *button = [BlockCalendarButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i * width / 7, 0, width / 7, self.frame.size.height);
        [button setClickBlock:^(BlockCalendarButton *button) {
            for (BlockCalendarButton *btn in _viewsArr) {
                btn.selected = NO;
            }
            button.selected = YES;
            
            if (_delegate && [_delegate respondsToSelector:@selector(weekDayDidSelectedWithBlockButton:)]) {
                [_delegate weekDayDidSelectedWithBlockButton:button];
            }
        }];
        
        [self addSubview:button];
//        [CalendarManager sharedManager];
        [_viewsArr addObject:button];
        
        if (i != 0) {
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(i * width / 7, 5, 1, self.frame.size.height - 10)];
            imgView.image = [UIImage imageNamed:@"icon_lineV"];
            [self addSubview:imgView];
        }
    }
}

- (void)setBeginningOfWeek:(NSDate *)date withDate:(NSDate *)currentPageDate orderNum:(NSDictionary *)orderNumDic
{
    //<* 这个方法是计算当前日期在本月第几周上面。第几周就是在第几个weekview上面了 *>
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitDay fromDate:date];

    NSInteger weekDay = [comp weekday];
    NSInteger day = [comp day];
    //计算当前日期和这周的星期一和星期天差的天数
    long firstDiff, lastDiff;
    if (weekDay == 1) {
        firstDiff = 0;
        lastDiff = 0;
    }
    else
    {
        firstDiff = [calendar firstWeekday] - weekDay;
        lastDiff = 9 - weekDay;
    }
    
    //在当前日期（去掉了时分秒）基础上加上差的天数
    NSDateComponents *firstDayComp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    [firstDayComp setDay:day + firstDiff];
    NSDate *firstDayOfWeek = [calendar dateFromComponents:firstDayComp];
    
    NSDateComponents *lastDayComp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    [lastDayComp setDay:day + lastDiff];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    [format setDateFormat:@"dd"];
    NSInteger firstDay = [format stringFromDate:firstDayOfWeek].integerValue;
    [format setDateFormat:@"MM"];
    NSInteger monthDay = [format stringForObjectValue:firstDayOfWeek].integerValue;
    
    //<* 获取当月天数 *>
    NSRange daysRange = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:currentPageDate];
    
    NSDateComponents *dayComponent = [NSDateComponents new];
    dayComponent.day = 1;
    
    NSDate *currentDate = firstDayOfWeek;
    for (int i = 0; i < _viewsArr.count; i++) {
        
        BlockCalendarButton *button = (BlockCalendarButton *)_viewsArr[i];
        button.dateTime = currentDate;
        
        if ([currentDate isEqualToDate:date])
        {
            button.selected = YES;
        }
        
        NSDateFormatter *currentFormatter = [[NSDateFormatter alloc] init];
        [currentFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *currentStr = [currentFormatter stringFromDate:currentDate];
        
        /** < 获取当前所在的年月 > **/
        NSDateFormatter *currentFormatter1 = [[NSDateFormatter alloc] init];
        [currentFormatter1 setDateFormat:@"yyyy-MM"];
        NSString *currentStr1 = [currentFormatter1 stringFromDate:currentDate];
        
        
        NSString *dayStr = [NSString stringWithFormat:@"%ld", firstDay++];
        
        currentStr = [NSString stringWithFormat:@"%@-%@",currentStr1,dayStr];
        if (dayStr.length == 1)/** < 当天数是一位数时候 弄成两位数 与key保持一致 > **/
        {
            currentStr = [NSString stringWithFormat:@"%@-0%@",currentStr1,dayStr];
        }
        
//        DLog(@"比较的时间：%@",currentStr);
        
        [button setButtonTitleWithTitle:dayStr];
        
        /** < 只是为了查看当前在几月份 > **/
        /**
         NSInteger currentMonth = [self monthDay:[NSDate date]];
         NSInteger nowMonth = [self monthDay:currentDate];
         NSLog(@"当前月：%ld -- 滑动月：%ld",currentMonth,nowMonth);
         
         if (currentMonth == nowMonth)
         {
         NSLog(@"******************\n      当前月份呢   \n******************");
         }

         */
       
        
        NSArray *orderArr = [orderNumDic allKeys];
        
        /** < 按照key原来的顺序 排序> **/
        orderArr = [orderArr sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
            NSComparisonResult result = [obj1 compare:obj2];
            return result == NSOrderedDescending;
        }];
        for (NSString *orderTime in orderArr)
        {
            
            if ([currentStr1 isEqualToString:[orderTime substringToIndex:7]])/** < 先比较是不当月的 > **/
            {
                if ([currentStr isEqualToString:orderTime])/** < 比较获取当月某天的保修个数 > **/
                {
//                    DLog(@"111111111111111111");
                    [button setLableText:orderNumDic[orderTime]];
                }
            }
            else /** < 不是当月的就不显示文字 > **/
            {
//                DLog(@"222222222222222222222");
                [button setHiddenLable];
            }
            
            
        }
        
        if (firstDay > daysRange.length)
        {
             NSLog(@"当月多少天%ld",daysRange.length);
            firstDay = 1;
            monthDay++;
            if (monthDay >12) {
                monthDay = 1;
            }
        }
        
        currentDate = [calendar dateByAddingComponents:dayComponent toDate:currentDate options:0];
    }
}


- (NSInteger)monthDay:(NSDate*)data
{
    
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateFormatter *formtter = [[NSDateFormatter alloc] init];
    [formtter setDateFormat:@"yyyy-MM-dd-HH-mm-ss"];//时间格式
    
    NSDate *date = [formtter dateFromString:[self creatTimeData:data]];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    unsigned int unitFlags =
    NSCalendarUnitYear|
    NSCalendarUnitMonth|
    NSCalendarUnitWeekday|
    NSCalendarUnitDay|
    NSCalendarUnitHour|
    NSCalendarUnitMinute|
    NSCalendarUnitSecond;
    /**
     *  @author HHL, 15-08-07 14:08:22
     *
     *  获取到当天此刻的 年 月 日 时 分 秒
     */
    comps = [calendar components:unitFlags fromDate:date];
    NSInteger year  = [comps year];
    NSInteger week  = [comps weekday];
    NSInteger month = [comps month];
    NSInteger day   = [comps day];
    NSInteger hour  = [comps hour];
    NSInteger min   = [comps minute];
    NSInteger sec   = [comps second];
    
    
    
    
    NSLog(@"今天是：【%ld-%ld-%ld-%ld-%ld-%ld -%ld】",year,month,day,hour,min,sec,week);
    return month;
}

//时间
-(NSString*)creatTimeData:(NSDate*)date
{
    NSDateFormatter *dateFormateter = [[NSDateFormatter alloc] init];
    [dateFormateter setDateFormat:@"yyyy-MM-dd-HH-mm-ss"];
    NSString *dataString = [dateFormateter stringFromDate:date];
    return dataString;
}

@end
