//
//  CalendarViewController.m
//  baoxiu51
//
//  Created by baoxiuyizhantong on 15/7/23.
//  Copyright (c) 2015年 baoxiuyizhantong. All rights reserved.
//

#import "CalendarViewController.h"
#import "CalendarTableViewCell.h"
#import "CalendarManager.h"
#import "CalendarScrollView.h"
#import "HHDatePickerView.h"
#import "Common.h"
#import "BXUserHeader.h"

@interface CalendarViewController () <UITableViewDataSource, UITableViewDelegate, HHDatePickerDelegate>
{
    UIButton *dateBtn;
    UIView *calendarView;
    
    CalendarScrollView *calendarScrollview;
    HHDatePickerView *selectCalendarView;
    
    NSDictionary *dateDic; //<* 日期字典 *>
    NSArray *dataArr; //<* 订单数据 *>
}

@property (nonatomic, strong) UIButton *btn_currentDate;
@property (nonatomic, strong) UITableView *myTableview;

@end

@implementation CalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //    即是否根据按所在界面的navigationbar与tabbar的高度，自动调整scrollview的 inset,设置为no
    self.automaticallyAdjustsScrollViewInsets = NO;
    
//    [self getDateData:[Common stringFromDate:[NSDate date] format:@"yyyy-MM"]];
//    [self getOrderData];
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
//    self.tabBarController.navigationItem.titleView = nil;
//    self.tabBarController.title = nil;
//    self.tabBarController.navigationItem.leftBarButtonItem = nil;
//    self.tabBarController.navigationItem.rightBarButtonItem = nil;
    
    [self initNavgationBar];
}

#pragma mark - 初始化数据

- (void)getDateData:(NSString *)currentDate
{
    NSDate *date = [NSDate date];
    NSString *timeStr = [NSString stringWithFormat:@"%d", (int)[date timeIntervalSince1970]];
    NSString *usrName = @"ninjaffqy";
    NSString *pwd = @"123";
    NSString *pwdStr = [Common md5HexDigest:pwd];
    NSString *sign = [Common md5HexDigest:[NSString stringWithFormat:@"%@%@%@ios", timeStr, pwdStr, usrName]];
    NSString *urlStr = [NSString stringWithFormat:@"%@AppApi/get_master_month_order/client_type/ios/is_ios/1/q/%@/u/%@/t/%@", kURL, sign, usrName, timeStr];
    
    NSDictionary *params = @{@"addtime":currentDate};
    
    [Common sendPostURL:urlStr withParams:params success:^(id responseObj) {
        
        NSLog(@"%@", responseObj);
        if ([responseObj[@"status"] integerValue] == 1) {
            
            dateDic = responseObj[@"info"];
            DLog(@"%@", dateDic);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"showOderNum" object:dateDic];
            
            calendarScrollview.orderNumDic = dateDic;
        }
        
    } failure:^(NSError *error) {
        
//        [Common showAlert:@"网络请求失败"];
    }];
}

- (void)getOrderData
{
    NSDate *date = [NSDate date];
    NSString *timeStr = [NSString stringWithFormat:@"%d", (int)[date timeIntervalSince1970]];
    NSString *usrName = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
    NSString *pwd = [[NSUserDefaults standardUserDefaults] objectForKey:@"userPwd"];
    NSString *pwdStr = [Common md5HexDigest:pwd];
    NSString *sign = [Common md5HexDigest:[NSString stringWithFormat:@"%@%@%@ios", timeStr, pwdStr, usrName]];
    NSString *urlStr = [NSString stringWithFormat:@"%@AppApi/GetAllOrderList/client_type/ios/q/%@/u/%@/t/%@/", kURL, sign, usrName, timeStr];
    
    NSDictionary *params = @{@"addtime":[Common stringFromDate:date format:@"yyyy-MM-dd"]};
    [Common sendPostURL:urlStr withParams:params success:^(id responseObj) {
        
        DLog(@"%@", responseObj);
        if ([responseObj[@"status"] integerValue] == 1)
        {
            dataArr = responseObj[@"info"];
            
            [self.myTableview reloadData];
        }
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - 初始化界面

- (void)initNavgationBar
{
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 25, 25);
    [rightButton setImage:[UIImage  imageNamed:@"icon_location"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(item_rightClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    self.btn_currentDate = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn_currentDate.frame = CGRectMake(0, 0, 140, 44);
    [self.btn_currentDate setTitle:[Common stringFromDate:[NSDate date] format:@"yyyy年MM月dd日"] forState:UIControlStateNormal];
    [self.btn_currentDate setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.btn_currentDate.userInteractionEnabled = NO;
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 15, 15);
//    [leftButton setImage:[UIImage imageNamed:@"icon_expand"] forState:UIControlStateNormal];
    [leftButton setBackgroundColor:[UIColor redColor]];
    [leftButton addTarget:self action:@selector(item_selectDateClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithCustomView:self.btn_currentDate];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItems = @[item1, item2];
}

- (void)initView
{
    calendarView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kSCREENWIDTH, 75)];
    calendarView.backgroundColor = [UIColor colorWithRed:244.0 / 255.0 green:244.0 / 255.0 blue:244.0 / 255.0 alpha:1];
    [self.view addSubview:calendarView];
    
    [self initCalendarView];
    
    self.myTableview = [[UITableView alloc] initWithFrame:CGRectMake(0, kYH(calendarView), kSCREENWIDTH, kSCREENHEIGHT - 164 - 49) style:UITableViewStylePlain];
    self.myTableview.delegate = self;
    self.myTableview.dataSource = self;
    
    self.myTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.myTableview.tableHeaderView = ({
        
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREENWIDTH, 40)];
        UILabel *lableTip = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, kWIDTH(headerView) - 40, kHEIGHT(headerView) - 1)];
        lableTip.text = @"今日订单";
        lableTip.font = kFONT15;
        [headerView addSubview:lableTip];
        
        UIImageView *imgLinew = [[UIImageView alloc] initWithFrame:CGRectMake(0, kYH(lableTip), kSCREENWIDTH, 0.5)];
        imgLinew.image = [UIImage imageNamed:@"icon_line"];
        [headerView addSubview:imgLinew];
        
        headerView;
    });
    [self.view addSubview:self.myTableview];
    
    selectCalendarView = [[HHDatePickerView alloc] initWithFrame:CGRectMake( 0, kSCREENHEIGHT - 113 - 152, kSCREENWIDTH, 240) selectView:HHDatePickerViewModeDate];
    selectCalendarView.delegate = self;
    selectCalendarView.hidden = YES;
    [self.view addSubview:selectCalendarView];
}

- (void)initCalendarView
{
    NSArray *weekArr = @[@"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六"];
    
    UIView *weekView = [[UIView alloc] initWithFrame:CGRectMake(20, 0, kSCREENWIDTH - 40, 30)];
    [calendarView addSubview:weekView];
    for (int i = 0; i < weekArr.count; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i * kWIDTH(weekView) / weekArr.count, 0, kWIDTH(weekView) / weekArr.count, 30)];
        label.text = weekArr[i];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor colorWithRed:161.0 / 255.0 green:161.0 / 255.0 blue:161.0 / 255.0 alpha:1];
        label.font = kFONT12;
        [weekView addSubview:label];
    }
    
    UIImageView *imgLine1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 30, kSCREENWIDTH, 0.5)];
    imgLine1.image = [UIImage imageNamed:@"icon_line"];
    [calendarView addSubview:imgLine1];
    
//    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    leftBtn.frame = CGRectMake(10, kYH(imgLine1) + 13, 10, 10);
//    [leftBtn setImage:[UIImage imageNamed:@"icon_next_right"] forState:UIControlStateNormal];
//    leftBtn.tag = 10;
//    leftBtn.transform = CGAffineTransformMakeRotation(M_PI);
//    
//    [leftBtn addTarget:self action:@selector(btn_changeDateClick:) forControlEvents:UIControlEventTouchUpInside];
//    [calendarView addSubview:leftBtn];
//    
//    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    rightBtn.frame = CGRectMake(kSCREENWIDTH - 20, kYH(imgLine1) + 13, 10, 10);
//    [rightBtn setImage:[UIImage imageNamed:@"icon_next_right"] forState:UIControlStateNormal];
//    rightBtn.tag = 11;
//    [rightBtn addTarget:self action:@selector(btn_changeDateClick:) forControlEvents:UIControlEventTouchUpInside];
//    [calendarView addSubview:rightBtn];
    
    UIImageView *leftImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, kYH(imgLine1) + 13, 10, 10)];
    leftImg.image = [UIImage imageNamed:@"icon_next_right"];
    leftImg.transform = CGAffineTransformMakeRotation(M_PI);
    [calendarView addSubview:leftImg];
    
    UIImageView *rightImg = [[UIImageView alloc] initWithFrame:CGRectMake(kSCREENWIDTH - 20, kYH(imgLine1) + 13, 10, 10)];
    rightImg.image = [UIImage imageNamed:@"icon_next_right"];
    [calendarView addSubview:rightImg];
    
    calendarScrollview = [[CalendarScrollView alloc] initWithFrame:CGRectMake(kXW(leftImg), kYH(imgLine1), kSCREENWIDTH - 40, 36) ];
    calendarScrollview.contentSize = CGSizeMake(self.view.frame.size.width * 5, 36);
    calendarScrollview.pagingEnabled = YES;
    calendarScrollview.showsHorizontalScrollIndicator = NO;
    calendarScrollview.showsVerticalScrollIndicator = NO;
    calendarScrollview.bounces = NO;
    [calendarView addSubview:calendarScrollview];
    
    __block CalendarViewController *weakSelf = self;
    
    
    [calendarScrollview setScrollViewDelegateAndSetClickBlock:^(BlockCalendarButton *button) {
        NSDateFormatter *formatter = [CalendarManager sharedManager].formatter;
        NSString *timeStr = [formatter stringFromDate:button.dateTime];
        [weakSelf.btn_currentDate setTitle:timeStr forState:UIControlStateNormal];
        dateBtn = button;
        
    }];
    
    UIImageView *imgLine2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, kYH(calendarScrollview), kSCREENWIDTH, 0.5)];
    imgLine2.image = [UIImage imageNamed:@"icon_line"];
    [calendarView addSubview:imgLine2];
}

#pragma mark - 点击事件

- (void)item_rightClick
{
    
}

- (void)item_selectDateClick
{
    selectCalendarView.hidden = !selectCalendarView.hidden;
}

- (void)btn_changeDateClick:(UIButton *)button
{
    
}

#pragma mark - 代理

#pragma mark - selectCalendarView delegate

- (void)completeBtnClick:(NSDate *)date
{
    [self.btn_currentDate setTitle:[Common stringFromDate:date format:@"yyyy年MM月dd日"] forState:UIControlStateNormal];
    
    //<* 纠正上面选择的日期跟scrllovew上的日期相对应 *>
    NSDateComponents *dayComponent = [NSDateComponents new];
    dayComponent.day = -7;
    NSCalendar *calendar = [CalendarManager sharedManager].calendar;
    NSDate *date1 = [calendar dateByAddingComponents:dayComponent toDate:date options:0];
    
    [calendarScrollview setCurrentWeekDate:date otherDate:date1];
}


#pragma mark - calendarview delegate

- (void)calendarView:(UIView *)view slectedIndex:(NSInteger)index
{
    
}

#pragma mark - tableview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"Cell";
    CalendarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[CalendarTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
    NSDictionary *dic = dataArr[indexPath.row];
    cell.lbl_product.text = [dic stringValueForKey:@"product_name" defaultValue:@"无"];
    cell.lbl_fault.text = [dic stringValueForKey:@"fault_detail" defaultValue:@"无"];
    cell.lbl_address.text = [dic stringValueForKey:@"address" defaultValue:@"无"];
    cell.lbl_status.text = [dic stringValueForKey:@"status" defaultValue:@"无"];
    
    cell.lbl_time.text = [Common stringFromDate:[Common dateFromString:dic[@"add_time"] format:@"yyyy-MM-dd HH:mm:ss"] format:@"HH:mm"];
    
    [cell changeColor:NO];
    if ([dic[@"status"] isEqualToString:@"已生成"]) {
        cell.lbl_status.textColor = [UIColor colorWithRed:255.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1];
    }
    else if ([dic[@"status"] isEqualToString:@"已接单"])
    {
        cell.lbl_status.textColor = [UIColor colorWithRed:254.0/255.0 green:162.0/255.0 blue:0/255.0 alpha:1];
    }
    else if ([dic[@"status"] isEqualToString:@"已付款"])
    {
        cell.lbl_status.textColor = [UIColor colorWithRed:102.0/255.0 green:204.0/255.0 blue:102.0/255.0 alpha:1];
    }
    else if ([dic[@"status"] isEqualToString:@"已评价"])
    {
        cell.lbl_status.textColor = [UIColor colorWithRed:0 green:51.0/255.0 blue:153.0/255.0 alpha:1];
    }
    else
    {
        cell.lbl_status.textColor = [UIColor blackColor];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

@end
