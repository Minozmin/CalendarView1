//
//  CalendarScrollView.m
//  text
//
//  Created by baoxiuyizhantong on 15/7/27.
//  Copyright (c) 2015年 BX. All rights reserved.
//

#import "CalendarScrollView.h"
#import "CalendarView.h"
#import "CalendarManager.h"

@interface CalendarScrollView () <UIScrollViewDelegate, CalendarViewDelegate>

@property (nonatomic, copy) void (^daySelected)(BlockCalendarButton *button);

@end

@implementation CalendarScrollView
{
    NSMutableArray *viewArrays;
    NSString *selectDate;
    NSInteger pageNum;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self uiConfig];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifi:) name:@"showOderNum" object:nil];
    }
    return self;
}

- (void)uiConfig
{
    viewArrays = [[NSMutableArray alloc] init];
    
    [CalendarManager sharedManager].currentDate = [NSDate date];
    self.currentDate = [CalendarManager sharedManager].currentDate;
    self.currentDate = [NSDate date];
    NSDateFormatter *formatter = [CalendarManager sharedManager].formatter;
    selectDate = [formatter stringFromDate:self.currentDate];
    
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    pageNum = self.contentSize.width / self.frame.size.width;
    for (int i = 0; i < 3; i++) {
        
        CalendarView *week = [[CalendarView alloc] initWithFrame:CGRectMake(width * i, 0, width, height)];
        week.delegate = self;
        [self addSubview:week];
        [viewArrays addObject:week];
    }
    
    self.contentOffset = CGPointMake(width * 1, 0);
    
    [self setCurrentWeekDate:self.currentDate otherDate:self.currentDate];//设置显示的日子
    [self setBlockButtonSelected];//设置当前选中的day
}

- (void)notifi:(NSNotification *)nofi
{
    self.orderNumDic = nofi.object;
    
    [self setCurrentWeekDate:self.currentDate otherDate:self.currentDate];
    
    NSLog(@"%@", self.orderNumDic);
}

#pragma mark - 设置日期选中状态

- (void)setCurrentWeekDate:(NSDate *)currentDate otherDate:(NSDate *)currentPageDate
{
    /** < date1 是当前页的 对应星期几 的那一天> **/
    for (int i = 0; i < 3; i++) {
        CalendarView *week = viewArrays[i];
        NSDateComponents *dayComponent = [NSDateComponents new];
        dayComponent.day = 7 * (i - viewArrays.count / 2);
        NSCalendar *calendar = [CalendarManager sharedManager].calendar;
        NSDate *date = [calendar dateByAddingComponents:dayComponent toDate:currentDate options:0];
        [week setBeginningOfWeek:date withDate:currentPageDate orderNum:self.orderNumDic];
        self.currentDate = currentDate;
        
        if (i == 2) {
            NSDateFormatter *formatter = [CalendarManager sharedManager].formatter;
            NSString *time = [formatter stringFromDate:currentDate];
            [self setSelectDate:time];
        }
    }
}

- (void)setSelectDate:(NSString *)selectDateStr
{
    for (CalendarView *week in viewArrays) {
        for (BlockCalendarButton *button in week.viewsArr) {
            if ([button.dateStr isEqualToString:selectDateStr]) {
                button.selected = YES;
            }
            else
            {
                button.selected = NO;
            }
        }
    }
}

- (void)setBlockButtonSelected
{
    for (CalendarView *week in viewArrays) {
        for (BlockCalendarButton *button in week.viewsArr) {
            if ([button.dateStr isEqualToString:selectDate]) {
                button.selected = YES;
            }
            else
            {
                button.selected = NO;
            }
        }
    }
}

//设置回调
- (void)setScrollViewDelegateAndSetClickBlock:(void (^)(BlockCalendarButton *))clickedBlock
{
    self.delegate = self;
    [self updatePage];
    _daySelected = [clickedBlock copy];
}

//选择日期的时候，进行 Block() 回调
-(void)weekDayDidSelectedWithBlockButton:(BlockCalendarButton *)button
{
    selectDate = button.dateStr;
    self.daySelected(button);
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self updatePage];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self updatePage];
}

- (void)updatePage
{
    CGFloat pageWidth = CGRectGetWidth(self.frame);
    CGFloat fractonalPage = self.contentOffset.x / pageWidth;
    
    self.currentPage = roundf(fractonalPage);//四舍五入
    
    NSCalendar *calendar = [CalendarManager sharedManager].calendar;
    
    NSLog(@"滑动到第几个页面%ld",self.currentPage);
    if (self.currentPage == 3 / 2) {
        
    }

    
    NSDateComponents *dayComponent1 = [NSDateComponents new];
    dayComponent1.day = 5 * (self.currentPage - 3 / 2);

    
    NSDate *data = [NSDate date];
    data = self.currentDate;
    /** < 这是为了传递现在这个页面的时间 而不是要传 这个页面所在时间的下一周 > **/
    
    /**
     *  @author HHL, 15-08-06 17:08:04
     *
     *  判断是不是左滑的
     */
    if (self.currentPage -3/2 < 0)
    {
        NSDateComponents *comp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitDay fromDate:self.currentDate];
        NSInteger day = [comp day];
        NSInteger week = [comp weekday];
        /**
         *  判断下当前日期减去7 是不是小于当前日期的星期几 小的话 就说明再一次向左滑动的时候 是前一个月了
         因此日期要进去今天距离月初的时间 就是前一个月 这样就获取了当月的天数
         */
        if (day < 7)
        {
            
        }
        else if (day - 7 < week)
        {
            /** < 在currentData日期的基础上 添加时间 > **/
            NSDateComponents *dayComponent = [NSDateComponents new];
            dayComponent.day = - day;
            data = [calendar dateByAddingComponents:dayComponent toDate:self.currentDate options:0];
            NSLog(@"天数：%@",data);
        }
        
    }
    
    NSDateComponents *dayComponent = [NSDateComponents new];
    dayComponent.day = 7 * (self.currentPage - 3 / 2);
    self.currentDate = [calendar dateByAddingComponents:dayComponent toDate:self.currentDate options:0];
    
    self.contentOffset = CGPointMake(pageWidth * (3 / 2), self.contentOffset.y);
    
    [self setCurrentWeekDate:self.currentDate otherDate:data];
    [self setBlockButtonSelected];
}

@end
