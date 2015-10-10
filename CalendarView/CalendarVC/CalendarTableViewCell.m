//
//  CalendarTableViewCell.m
//  baoxiu51
//
//  Created by baoxiuyizhantong on 15/7/24.
//  Copyright (c) 2015年 baoxiuyizhantong. All rights reserved.
//

#import "CalendarTableViewCell.h"
#import "BXUserHeader.h"

@implementation CalendarTableViewCell
{
    UILabel *productLbl;
    UILabel *faultLbl;
    UILabel *addrLbl;
    UILabel *statusLbl;
}

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _lbl_time = [[UILabel alloc] initWithFrame:CGRectMake(15, 30, 35, 20)];
        _lbl_time.font = kFONT12;
        [self addSubview:_lbl_time];
        
        _img_time = [[UIImageView alloc] initWithFrame:CGRectMake(kXW(_lbl_time), kY(_lbl_time), 20, 20)];
        [self addSubview:_img_time];
        
        _img_line = [[UIImageView alloc] initWithFrame:CGRectMake(kYH(_lbl_time) + 10, 0, 1, 30)];
        _img_line.image = [UIImage imageNamed:@"icon_calendar_lineV"];
        [self addSubview:_img_line];
        
        UIImageView *imgLineV = [[UIImageView alloc] initWithFrame:CGRectMake(kX(_img_line), kYH(_img_time), 1, kHEIGHT(_img_line))];
        imgLineV.image = [UIImage imageNamed:@"icon_calendar_lineV"];
        [self addSubview:imgLineV];
        
        productLbl = [[UILabel alloc] initWithFrame:CGRectMake(kXW(_img_time) + 14, 10, 65, 15)];
        faultLbl = [[UILabel alloc] initWithFrame:CGRectMake(kX(productLbl), kYH(productLbl), kWIDTH(productLbl), kHEIGHT(productLbl))];
        addrLbl = [[UILabel alloc] initWithFrame:CGRectMake(kX(faultLbl), kYH(faultLbl), kWIDTH(faultLbl), kHEIGHT(faultLbl))];
        
        statusLbl = [[UILabel alloc] initWithFrame:CGRectMake(kX(addrLbl), kYH(addrLbl), kWIDTH(addrLbl), kHEIGHT(addrLbl))];
        
        productLbl.text = @"报修产品:";
        faultLbl.text = @"产品故障:";
        addrLbl.text = @"报修地址:";
        statusLbl.text = @"订单状态:";
        
        productLbl.font = kFONT12;
        faultLbl.font = kFONT12;
        addrLbl.font = kFONT12;
        statusLbl.font = kFONT12;
        
        [self addSubview:productLbl];
        [self addSubview:faultLbl];
        [self addSubview:addrLbl];
        [self addSubview:
         
         statusLbl];
        
        _lbl_product = [[UILabel alloc] initWithFrame:CGRectMake(kXW(productLbl), kY(productLbl), kSCREENWIDTH - kXW(productLbl) - 15, kHEIGHT(productLbl))];
        _lbl_fault = [[UILabel alloc] initWithFrame:CGRectMake(kX(_lbl_product), kY(faultLbl), kWIDTH(_lbl_product), kHEIGHT(_lbl_product))];
        _lbl_address = [[UILabel alloc] initWithFrame:CGRectMake(kX(_lbl_fault), kY(addrLbl), kWIDTH(_lbl_fault), kHEIGHT(_lbl_fault))];
        _lbl_status = [[UILabel alloc] initWithFrame:CGRectMake(kX(_lbl_address), kY(statusLbl), kWIDTH(_lbl_address), kHEIGHT(_lbl_address))];
        
        _lbl_product.font = kFONT12;
        _lbl_fault.font = kFONT12;
        _lbl_address.font = kFONT12;
        _lbl_status.font = kFONT12;
        
        [self addSubview:_lbl_product];
        [self addSubview:_lbl_fault];
        [self addSubview:_lbl_address];
        [self addSubview:_lbl_status];
        
        UIImageView *imgLine = [[UIImageView alloc] initWithFrame:CGRectMake(kX(productLbl), 79, kSCREENWIDTH - kX(productLbl) - 15, 0.5)];
        imgLine.image = [UIImage imageNamed:@"icon_line"];
        [self addSubview:imgLine];
    }
    return self;
}

- (void)changeColor:(BOOL)isFail
{
    if (isFail == YES) {
        
        productLbl.textColor = kColorOrderStatusFail;
        faultLbl.textColor = kColorOrderStatusFail;
        addrLbl.textColor = kColorOrderStatusFail;
        statusLbl.textColor = kColorOrderStatusFail;
        
        self.lbl_product.textColor = kColorOrderStatusFail;
        self.lbl_fault.textColor = kColorOrderStatusFail;
        self.lbl_address.textColor = kColorOrderStatusFail;
        self.lbl_status.textColor = kColorOrderStatusFail;
        
        self.lbl_time.textColor = kColorOrderStatusFail;
        
        self.img_time.image = [UIImage imageNamed:@"icon_status_fail"];
    }
    else{
        
        productLbl.textColor = kColorGray153;
        faultLbl.textColor = kColorGray153;
        addrLbl.textColor = kColorGray153;
        statusLbl.textColor = kColorGray153;
        
        self.lbl_product.textColor = kColorGray153;
        self.lbl_fault.textColor = kColorGray153;
        self.lbl_address.textColor = kColorGray153;
//        self.lbl_status.textColor = kColorGray153;
        
        self.lbl_time.textColor = kColorGray153;
    }
}

@end
