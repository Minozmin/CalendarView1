//
//  BlockCalendarButton.m
//  text
//
//  Created by baoxiuyizhantong on 15/7/27.
//  Copyright (c) 2015年 BX. All rights reserved.
//

#import "BlockCalendarButton.h"
#import "CalendarManager.h"
#import "BXUserHeader.h"

@implementation BlockCalendarButton
{
    UILabel *_label;
}

- (void)setClickBlock:(void (^)(BlockCalendarButton *))clickBlock
{
    _label = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width / 2 + 5, 5, 10, 10)];
    _label.hidden = YES;
    _label.font = kFONT10;
    _label.backgroundColor = [UIColor redColor];
    _label.textColor = [UIColor whiteColor];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.layer.cornerRadius = 5;
    _label.layer.masksToBounds = YES;
    [self addSubview:_label];
    
    self.titleLabel.font = kFONT15;
    [self setTitleColor:[UIColor colorWithRed:119.0 / 255.0 green:119.0 / 255.0 blue:119.0 / 255.0 alpha:1] forState:UIControlStateNormal];
    [self setTitleColor:kColorlumpOrangeDark forState:UIControlStateSelected];
    [self addTarget:self action:@selector(btn_pressedClick:) forControlEvents:UIControlEventTouchUpInside];
    self.buttonClicked = [clickBlock copy];
}

- (void)btn_pressedClick:(UIButton *)button
{
    button.selected = !button.selected;
    self.buttonClicked(button);
}

- (void)setDateTime:(NSDate *)dateTime
{
    _dateTime = dateTime;
    NSDateFormatter *formatter = [CalendarManager sharedManager].formatter;
    _dateStr = [formatter stringFromDate:dateTime];
}

- (void)setButtonTitleAttributedString:(NSAttributedString *)titleString
{
    [self setTitle:titleString.string forState:UIControlStateNormal];
    self.titleLabel.attributedText = titleString;
}

- (void)setButtonTitleWithTitle:(NSString *)title
{
    self.weekStr = title;
    [self setTitle:title forState:UIControlStateNormal];
}

- (void)setLableText:(NSString *)text
{
    _label.hidden = NO;
//    _label.textColor = [UIColor greenColor];
    _label.text = text;
}
- (void)setHiddenLable
{
    _label.hidden = YES;
    //    _label.textColor = [UIColor greenColor];
}

@end
