//
//  CalendarView.h
//  baoxiu51
//
//  Created by baoxiuyizhantong on 15/7/24.
//  Copyright (c) 2015年 baoxiuyizhantong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BlockCalendarButton.h"

@protocol CalendarViewDelegate <NSObject>

- (void)weekDayDidSelectedWithBlockButton:(BlockCalendarButton *)button;

@end

@interface CalendarView : UIView

@property (nonatomic, strong) NSMutableArray *viewsArr;
@property (nonatomic, assign) id<CalendarViewDelegate> delegate;

- (void)setBeginningOfWeek:(NSDate *)date withDate:(NSDate *)currentPageDate orderNum:(NSDictionary *)orderNumDic;

@end
