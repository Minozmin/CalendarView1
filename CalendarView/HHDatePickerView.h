//
//  HHDatePickerView.h
//  baoxiu51
//
//  Created by baoxiuyizhantong on 15/7/10.
//  Copyright (c) 2015年 baoxiuyizhantong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    HHDatePickerViewModeTime = 0,
    HHDatePickerViewModeDate = 1,
    HHDatePickerViewModeDateAndTime = 2
}HHDatePickerViewMode;

@protocol HHDatePickerDelegate <NSObject>

- (void)completeBtnClick:(NSDate *)date;

@end

@interface HHDatePickerView : UIView

- (instancetype)initWithFrame:(CGRect)frame selectView:(NSInteger)index;
@property (nonatomic) HHDatePickerViewMode dateType;

@property (nonatomic, assign) id<HHDatePickerDelegate> delegate;


@end
