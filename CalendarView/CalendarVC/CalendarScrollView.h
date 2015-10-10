//
//  CalendarScrollView.h
//  text
//
//  Created by baoxiuyizhantong on 15/7/27.
//  Copyright (c) 2015年 BX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BlockCalendarButton.h"

@interface CalendarScrollView : UIScrollView

@property (nonatomic, strong) NSDate *currentDate;//每一页当前时间，用于计算并显示每周的日期的
@property (nonatomic, assign) NSInteger currentPage;

@property (nonatomic, strong) NSDictionary *orderNumDic;

- (void)setScrollViewDelegateAndSetClickBlock:(void(^)(BlockCalendarButton *button))clickedBlock;
- (void)setCurrentWeekDate:(NSDate *)currentDate otherDate:(NSDate *)currentPageDate;
@end
