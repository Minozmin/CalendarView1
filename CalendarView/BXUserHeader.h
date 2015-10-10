//
//  BXUserHeader.h
//  BXUser
//
//  Created by baoxiuyizhantong on 15/3/4.
//  Copyright (c) 2015年 baoxiuyizhantong. All rights reserved.
//

#ifndef BXUser_BXUserHeader_h
#define BXUser_BXUserHeader_h

#define kSIDEBGCOLOR             [UIColor colorWithRed:54.0 / 255.0 green:57.0 / 255.0 blue:81.0 / 255.0 alpha:1]
#define kPICKERBGCOLOR           [UIColor colorWithRed:254.0 / 255.0 green:254.0 / 255.0 blue:241.0 / 255.0 alpha:1]

#define kColorCalendarSelected   [UIColor colorWithRed:254.0 / 255.0 green:162.0 / 255.0 blue:0 / 255.0 alpha:1]
#define kColorCalendarNormal     [UIColor colorWithRed:119.0 / 255.0 green:119.0 / 255.0 blue:119.0 / 255.0 alpha:1]
#define kColorOrderStatusFail    [UIColor colorWithRed:204.0 / 255.0 green:204.0 / 255.0 blue:204.0 / 255.0 alpha:1]
#define kColorOrderStatusManage   [UIColor colorWithRed:255.0 / 255.0 green:0 / 255.0 blue:0 / 255.0 alpha:1]
#define kColorOrderStatusSuccess  [UIColor colorWithRed:84.0 / 255.0 green:203.0 / 255.0 blue:108.0 / 255.0 alpha:1]

#define kColorBlack51           [UIColor colorWithRed:51.0 / 255.0 green:51.0 / 255.0 blue:51.0 / 255.0 alpha:1]
#define kColorBlack85           [UIColor colorWithRed:85.0 / 255.0 green:85.0 / 255.0 blue:85.0 / 255.0 alpha:1]
#define kColorBlack102          [UIColor colorWithRed:102.0 / 255.0 green:102.0 / 255.0 blue:102.0 / 255.0 alpha:1]
#define kColorBlack132          [UIColor colorWithRed:132.0 / 255.0 green:132.0 / 255.0 blue:132.0 / 255.0 alpha:1]

#define kColorlumpOrangeDark         [UIColor colorWithRed:254.0 / 255.0 green:161.0 / 255.0 blue:41.0 / 255.0 alpha:1]
#define kColorlumpOrangeLight         [UIColor colorWithRed:245.0 / 255.0 green:207.0 / 255.0 blue:154.0 / 255.0 alpha:1]
#define kColorlumpGreen         [UIColor colorWithRed:80.0 / 255.0 green:204.0 / 255.0 blue:150.0 / 255.0 alpha:1]
#define kColorlumpCyan          [UIColor colorWithRed:84.0 / 255.0 green:203.0 / 255.0 blue:108.0 / 255.0 alpha:1]
#define kColorlumpWhite         [UIColor colorWithRed:255.0 / 255.0 green:255.0 / 255.0 blue:255.0 / 255.0 alpha:1]
#define kColorlumpGrey          [UIColor colorWithRed:245.0 / 255.0 green:248.0 / 255.0 blue:245.0 / 255.0 alpha:1]
#define kColorlumpGray          [UIColor colorWithRed:153.0 / 255.0 green:153.0 / 255.0 blue:153.0 / 255.0 alpha:1]

#define kColorGray153          [UIColor colorWithRed:153.0 / 255.0 green:153.0 / 255.0 blue:153.0 / 255.0 alpha:1]
#define kColorGray181           [UIColor colorWithRed:181.0 / 255.0 green:181.0 / 255.0 blue:181.0 / 255.0 alpha:1]
#define kColorGray202          [UIColor colorWithRed:202.0 / 255.0 green:202.0 / 255.0 blue:202.0 / 255.0 alpha:1]

#define kColorBg                [UIColor colorWithRed:244.0 / 255.0 green:244.0 / 255.0 blue:244.0 / 255.0 alpha:1]

#define kFONT16                  [UIFont systemFontOfSize:16.0f]
#define kFONT15                  [UIFont systemFontOfSize:15.0f]
#define kFONT14                  [UIFont systemFontOfSize:14.0f]
#define kFONT13                  [UIFont systemFontOfSize:13.0f]
#define kFONT12                  [UIFont systemFontOfSize:12.0f]
#define kFONT11                  [UIFont systemFontOfSize:11.0f]
#define kFONT10                  [UIFont systemFontOfSize:10.0f]

#define kBTNWIDTH                280
#define kBTNHIGHT                38
#define kSPACE5                  5
#define kSIDEWIDTH               243
#define kPAOPAOWIDTH             200
#define KPAOPAOHIGHT             150

#define kSCREENHEIGHT      [UIScreen mainScreen].bounds.size.height
#define kSCREENWIDTH       [UIScreen mainScreen].bounds.size.width
#define kX(a)             CGRectGetMinX(a.frame)//(v).frame.origin.x
#define kY(a)             CGRectGetMinY(a.frame)//(v).frame.origin.y
#define kXW(a)            CGRectGetMaxX(a.frame)//(v).frame.origin.x + (v).frame.size.width
#define kYH(a)            CGRectGetMaxY(a.frame)//(v).frame.origin.y + (v).frame.size.height
#define kWIDTH(a)         CGRectGetWidth(a.frame)//(v).frame.size.width
#define kHEIGHT(a)        CGRectGetHeight(a.frame)//(v).frame.size.height

#ifdef DEBUG

#   define DLog(fmt, ...) {NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);}
#   define ELog(err) {if(err) DLog(@"%@", err)}
#else
#   define DLog(...)
#   define ELog(err)

#endif


#define UMAPPKEY     @"55a7570167e58eeb35001bbe"

#define WXAPPID      @"wx61c29180f7a4888f"
#define WXAPPSECRET  @"wx61c29180f7a4888f"

#define QQAPPID      @"1104696151"
#define QQAPPKEY     @"wx61c29180f7a4888f"


//http://192.168.0.30/Repair/test_push/repair_id/8891
//#define kURL                     @"http://192.168.0.77/"          //测试
#define kURL                   @"http://www.51baoxiu.com/"        //正式

#endif
