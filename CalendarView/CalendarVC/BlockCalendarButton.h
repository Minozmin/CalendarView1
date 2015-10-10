//
//  BlockCalendarButton.h
//  text
//
//  Created by baoxiuyizhantong on 15/7/27.
//  Copyright (c) 2015年 BX. All rights reserved.
//

#import <UIKit/UIKit.h>

//@protocol BlockCalendarClikcedDelgate <NSObject>
//
//- (void)setBlockClieckedSelected:(NSInteger)index;
//
//@end

@interface BlockCalendarButton : UIButton

@property (nonatomic, copy) void(^buttonClicked)(UIButton *button);

@property (nonatomic, copy) NSString *weekStr;//星期
@property (nonatomic, copy) NSString *dateStr;//日期
@property (nonatomic, strong) NSDate *dateTime;

- (void)setClickBlock:(void(^)(BlockCalendarButton *button))clickBlock;

- (void)setButtonTitleAttributedString:(NSAttributedString *)titleString;
- (void)setButtonTitleWithTitle:(NSString *)title;

- (void)setLableText:(NSString *)text;
- (void)setHiddenLable;

//@property (nonatomic, assign) id<BlockCalendarClikcedDelgate> delegate;

@end
