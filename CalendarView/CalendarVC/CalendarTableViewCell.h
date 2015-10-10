//
//  CalendarTableViewCell.h
//  baoxiu51
//
//  Created by baoxiuyizhantong on 15/7/24.
//  Copyright (c) 2015年 baoxiuyizhantong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalendarTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *img_time;
@property (nonatomic, strong) UIImageView *img_line;
@property (nonatomic, strong) UILabel *lbl_time;
@property (nonatomic, strong) UILabel *lbl_product;
@property (nonatomic, strong) UILabel *lbl_fault;
@property (nonatomic, strong) UILabel *lbl_address;
@property (nonatomic, strong) UILabel *lbl_status;

- (void)changeColor:(BOOL)isFail;

@end
