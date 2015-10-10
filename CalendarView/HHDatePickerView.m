//
//  HHDatePickerView.m
//  baoxiu51
//
//  Created by baoxiuyizhantong on 15/7/10.
//  Copyright (c) 2015年 baoxiuyizhantong. All rights reserved.
//

#import "HHDatePickerView.h"
#import "BXUserHeader.h"

@implementation HHDatePickerView
{
    UIDatePicker *pickerview;
}

- (instancetype)initWithFrame:(CGRect)frame selectView:(NSInteger)index
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView *toolBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 40)];
        toolBar.image = [UIImage imageNamed:@"bg_time_sel"];
        [self addSubview:toolBar];
        
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.frame = CGRectMake(0, 10, 60, 30);
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:kColorlumpGreen forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(btn_cancelClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelBtn];
        
        UIButton *completeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        completeBtn.frame = CGRectMake(frame.size.width - 60, 10, 60, 30);
        [completeBtn setTitle:@"完成" forState:UIControlStateNormal];
        [completeBtn setTitleColor:kColorlumpGreen forState:UIControlStateNormal];
        [completeBtn addTarget:self action:@selector(btn_completeClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:completeBtn];
        
        pickerview = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, kYH(toolBar), kSCREENHEIGHT, 200)];
        pickerview.backgroundColor = kPICKERBGCOLOR;
        [pickerview setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_Hans_CN"]];//默认中文
        [self addSubview:pickerview];
        
        if (index == HHDatePickerViewModeTime) {
            pickerview.datePickerMode = UIDatePickerModeTime;
        }
        else if (index == HHDatePickerViewModeDate)
        {
            pickerview.datePickerMode = UIDatePickerModeDate;
        }
        else
        {
            pickerview.datePickerMode = UIDatePickerModeDateAndTime;
        }
    }
    return self;
}

#pragma mark - aciton view

- (void)btn_cancelClick:(UIButton *)button
{
    self.hidden = YES;
}

- (void)btn_completeClick:(UIButton *)button
{
    if (_delegate && [_delegate respondsToSelector:@selector(completeBtnClick:)]) {
        [_delegate completeBtnClick:pickerview.date];
        self.hidden = YES;
    }
}

@end
